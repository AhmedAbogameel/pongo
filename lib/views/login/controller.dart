import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pet_adoption/core/keywords/api.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:pet_adoption/core/services/shared_preferences.dart';

class LoginController {
  final String _apiKey = 'AIzaSyCMEFcYYsswdlK5hVOmn_PsPjw1cDjN9Vc';

  Future<UserModel> login(String email,String password)async{
    final String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey';
    UserModel _userModel = UserModel();
    final response = await http.post(
      url,
      body: jsonEncode(
        {
          APIKeywords.email: email,
          APIKeywords.password: password,
        },
      ),
    );
    final decodedResponse = jsonDecode(response.body);
    try {
      _userModel.message =
          decodedResponse['error']['message'].replaceAll('_', ' ');
    } catch (_) {
      _userModel.message = null;
      _userModel.email = decodedResponse[APIKeywords.email];
      _userModel.displayName = decodedResponse[APIKeywords.displayName];
      _userModel.photoUrl = decodedResponse[APIKeywords.photoUrl];
      _userModel.userId = decodedResponse[APIKeywords.localId];
      await PrefsFunctions().storeUserModel(_userModel);
    }
    return _userModel;
  }
}