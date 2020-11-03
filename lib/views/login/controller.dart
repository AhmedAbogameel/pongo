import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_adoption/core/keywords/api.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:pet_adoption/core/services/fcm.dart';
import 'package:pet_adoption/core/services/shared_preferences.dart';

class LoginController {
  final String _apiKey = 'AIzaSyCMEFcYYsswdlK5hVOmn_PsPjw1cDjN9Vc';

  Future<UserSingleton> login(String email,String password)async{
    final String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey';
    UserSingleton _userModel = UserSingleton();
    final response = await http.post(
      url,
      body: jsonEncode(
        {
          UserKeywords.email: email,
          UserKeywords.password: password,
        },
      ),
    );
    final decodedResponse = jsonDecode(response.body);
    try {
      _userModel.message =
          decodedResponse['error']['message'].replaceAll('_', ' ');
    } catch (_) {
      _userModel.message = null;
      _userModel.email = decodedResponse[UserKeywords.email];
      _userModel.displayName = decodedResponse[UserKeywords.displayName];
      _userModel.photoUrl = decodedResponse[UserKeywords.profilePicture];
      _userModel.userId = decodedResponse[UserKeywords.localId];
      _userModel.idToken = decodedResponse[UserKeywords.idToken];
      _userModel.isPremium = decodedResponse[UserKeywords.isPremium];
      await PrefsFunctions().storeUserModel();
      await FCM().setFCM();
    }
    return _userModel;
  }
}