// Singleton user class

import 'package:pet_adoption/core/keywords/shared_preferences.dart';

class UserModel {

  String displayName;
  String email;
  String photoUrl;
  String userId;
  String message;
  String idToken;

  factory UserModel(){
    return _userModel;
  }

  static UserModel _userModel = UserModel._initialize();
  UserModel._initialize();
  UserModel.fromJson(Map json){
    displayName = json[PrefsKeyWords.displayName];
    photoUrl = json[PrefsKeyWords.photoUrl];
    email = json[PrefsKeyWords.email];
    userId = json[PrefsKeyWords.userId];
    idToken = json[PrefsKeyWords.idToken];
  }

  Map toJson(){
    Map data = {};
    data[PrefsKeyWords.displayName] = displayName;
    data[PrefsKeyWords.photoUrl] = photoUrl;
    data[PrefsKeyWords.email] = email;
    data[PrefsKeyWords.userId] = userId;
    data[PrefsKeyWords.idToken]= idToken;
    return data;
  }
}