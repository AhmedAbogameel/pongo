import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/core/keywords/shared_preferences.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsFunctions {
  SharedPreferences _preferences;

  Future<void> storeUserModel() async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.clear();
    _preferences.setString(
      PrefsKeyWords.userModel,
      jsonEncode(
        UserSingleton.fromJson(
          UserSingleton().toJson(),
        ),
      ),
    );
  }

  Future<void> getUserModel() async {
    _preferences = await SharedPreferences.getInstance();
    if(_preferences.containsKey(PrefsKeyWords.userModel)){
      final userPrefsInfo =
      jsonDecode(_preferences.getString(PrefsKeyWords.userModel));
      UserSingleton _userModel = UserSingleton();
      _userModel.userId = userPrefsInfo[PrefsKeyWords.userId];
      _userModel.photoUrl = userPrefsInfo[PrefsKeyWords.photoUrl];
      _userModel.idToken = userPrefsInfo[PrefsKeyWords.idToken];
      _userModel.displayName = userPrefsInfo[PrefsKeyWords.displayName];
      _userModel.email = userPrefsInfo[PrefsKeyWords.email];
      _userModel.isPremium = userPrefsInfo[PrefsKeyWords.isPremium];
    }
    int storedAccentColor = _preferences.getInt('accentColor');
    if(storedAccentColor != null){
      kAccentColor = Color(storedAccentColor);
    }
  }
}
