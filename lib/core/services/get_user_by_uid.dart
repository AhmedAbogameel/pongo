import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_adoption/core/models/user_model.dart';

Future<UserModel> getUserByUID(String uid) async {
  final url = 'https://pongoo.firebaseio.com/users/$uid.json';
  final response =await http.get(url);
  final decodedResponse = jsonDecode(response.body);
  return UserModel.fromJson(decodedResponse);
}