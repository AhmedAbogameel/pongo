import 'dart:convert';
import 'package:pet_adoption/core/keywords/api.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:pet_adoption/core/services/fcm.dart';
import 'package:pet_adoption/core/services/shared_preferences.dart';
import 'package:pet_adoption/views/profile/controller.dart';

class SignUpController {
  final String _apiKey = 'AIzaSyCMEFcYYsswdlK5hVOmn_PsPjw1cDjN9Vc';
  static const String _logoUrl = 'https://firebasestorage.googleapis.com/v0/b/pongoo.appspot.com/o/logo.png?alt=media&token=a24a5356-028e-4e06-b6e1-93ebda95c739';
  Future<UserSingleton> signUp(
      String email, String password, String displayName) async {
    final String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey';
    UserSingleton _userModel = UserSingleton();
    final response = await http.post(
      url,
      body: jsonEncode(
        {
          UserKeywords.email: email,
          UserKeywords.password: password,
          UserKeywords.displayName: displayName,
        },
      ),
    );
    final decodedResponse = jsonDecode(response.body);
    try {
      _userModel.message =
          decodedResponse['error']['message'].replaceAll('_', ' ');
    } catch (_) {
      final userId = decodedResponse[UserKeywords.localId];
      _userModel.message = null;
      _userModel.email = email;
      _userModel.displayName = displayName;
      _userModel.photoUrl = _logoUrl;
      _userModel.userId = userId;
      _userModel.idToken = decodedResponse[UserKeywords.idToken];
      _userModel.isPremium = false;
      _addUserToDB(email, displayName, userId);
      await PrefsFunctions().storeUserModel();
      await ProfileController().updateProfile(displayName, _logoUrl);
      await FCM().setFCM();
    }
    return _userModel;
  }

  Future<void> _addUserToDB(email, displayName, userId) async {
    final String url = 'https://pongoo.firebaseio.com/users/$userId.json';
    await http.patch(
      url,
      body: jsonEncode(
        {
          UserKeywords.email: email,
          UserKeywords.displayName: displayName,
          UserKeywords.photoUrl: _logoUrl,
          UserKeywords.isPremium:false,
        },
      ),
    );
  }
}
