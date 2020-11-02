// Singleton user class

import 'package:pet_adoption/core/keywords/shared_preferences.dart';

class UserSingleton {

  String displayName;
  String email;
  String photoUrl;
  String userId;
  String message;
  String idToken;
  bool isPremium;

  factory UserSingleton(){
    return _userModel;
  }

  static UserSingleton _userModel = UserSingleton._initialize();
  UserSingleton._initialize();
  UserSingleton.fromJson(Map json){
    displayName = json[PrefsKeyWords.displayName];
    photoUrl = json[PrefsKeyWords.photoUrl];
    email = json[PrefsKeyWords.email];
    userId = json[PrefsKeyWords.userId];
    idToken = json[PrefsKeyWords.idToken];
    isPremium = json[PrefsKeyWords.isPremium];
  }

  Map toJson(){
    Map data = {};
    data[PrefsKeyWords.displayName] = displayName;
    data[PrefsKeyWords.photoUrl] = photoUrl;
    data[PrefsKeyWords.email] = email;
    data[PrefsKeyWords.userId] = userId;
    data[PrefsKeyWords.idToken]= idToken;
    data[PrefsKeyWords.isPremium] = isPremium;
    return data;
  }
}