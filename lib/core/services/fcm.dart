import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pet_adoption/core/models/user.dart';

class FCM {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  UserSingleton _userSingleton = UserSingleton();

  Future<String> setFCM() async {
    String token = await _firebaseMessaging.getToken();
    final String url =
        'https://pongoo.firebaseio.com/users/${_userSingleton.userId}/fcm.json';
    await http.patch(url, body: jsonEncode({token: 0}));
    return token;
  }
  
  Future<List<String>> getFCMTokenByUserId(String userId)async{
    final String url =
        'https://pongoo.firebaseio.com/users/$userId/fcm.json';
    final response = await http.get(url);
    final decodedResponse = jsonDecode(response.body);
    List<String> allFCMTokens = decodedResponse.keys.toList();
    return allFCMTokens;
  }

  final String _serverToken =
      'AAAAg1JzjlU:APA91bEIUuL_9ItwBF3duM0r9IeAK1TEnR2BuS5UNetE5is_pkEQR8TZeafEXz3_0cA9KN21avPQTIobQJR4yX9fOB7G0eulZEsJcjfjHupmNfOdAJu8ssjDzjCdw02KrGqw4Kepbjxh';
  
  Future<Map<String, dynamic>> pushNotification(
      {@required String sender,
      @required String message,
      @required String fcm}) async {
    print(fcm);
    await _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$_serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': message,
            'title': 'From : $sender',
            'sound': 'default'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': fcm,
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );

    return completer.future;
  }
}
