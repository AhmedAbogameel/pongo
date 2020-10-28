import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_adoption/core/keywords/api.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:pet_adoption/core/services/shared_preferences.dart';

class ProfileController {
  UserModel _userModel = UserModel();
  String _authUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:update?key=AIzaSyCMEFcYYsswdlK5hVOmn_PsPjw1cDjN9Vc';
  String _dBUrl = 'https://pongoo.firebaseio.com/users/${UserModel().userId}.json';

  Future<void> updateProfile(String displayName ,String photoUrl)async{
    final response = await http.post(_authUrl,body: jsonEncode({
      UserKeywords.idToken : UserModel().idToken,
      UserKeywords.displayName : displayName,
      UserKeywords.photoUrl : photoUrl,
    }));
    print(response.body);
    final decodedResponse = jsonDecode(response.body);
    _userModel.displayName = decodedResponse[UserKeywords.displayName];
    _userModel.photoUrl = decodedResponse[UserKeywords.photoUrl];
    await http.patch(_dBUrl,body: jsonEncode({
      UserKeywords.displayName : displayName,
      UserKeywords.photoUrl : photoUrl,
    }));
    await PrefsFunctions().storeUserModel();
  }

  Future<String> uploadFile({String path,@required File image}) async {
    String imgURL;
    try {
      StorageReference storageReference = FirebaseStorage.instance.ref().child(path ?? '${_userModel.userId}/userProfile');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      print('File Uploaded');
      await storageReference.getDownloadURL().then((fileURL) {
        imgURL = fileURL;
      });
      return imgURL;
    } catch (e) {
      return e.toString();
    }
  }

}