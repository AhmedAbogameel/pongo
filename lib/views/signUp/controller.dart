import 'dart:convert';
import 'package:pet_adoption/core/keywords/api.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:pet_adoption/core/services/shared_preferences.dart';

class SignUpController {
  final String _apiKey = 'AIzaSyCMEFcYYsswdlK5hVOmn_PsPjw1cDjN9Vc';

  Future<UserModel> signUp(
      String email, String password, String displayName) async {
    final String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey';
    UserModel _userModel = UserModel();
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
      _userModel.photoUrl = '';
      _userModel.userId = userId;
      _addUserToDB(email, displayName, userId);
      await PrefsFunctions().storeUserModel(_userModel);
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
          UserKeywords.photoUrl: '',
        },
      ),
    );
  }
}
