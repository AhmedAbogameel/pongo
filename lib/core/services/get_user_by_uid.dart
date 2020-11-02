import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_adoption/core/keywords/api.dart';
import 'package:pet_adoption/core/models/user_model.dart';

Future<UserModel> getUserByUID(String uid) async {
  UserModel _user = UserModel();
  final url = 'https://pongoo.firebaseio.com/users/$uid.json';
  final response =await http.get(url);
  final decodedResponse = jsonDecode(response.body);
  _user.userId = uid;
  _user.photoUrl = decodedResponse[UserKeywords.photoUrl];
  _user.email = decodedResponse[UserKeywords.email];
  _user.displayName = decodedResponse[UserKeywords.displayName];
  _user.fcmTokens = decodedResponse['fcm'].keys.toList();
  return _user;
}