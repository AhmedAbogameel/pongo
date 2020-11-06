import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/core/keywords/firestore.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:pet_adoption/core/services/fcm.dart';
import '../../constants.dart';

class SendMessageButton extends StatelessWidget {
  final TextEditingController messageController;
  final String wantedUserId;
  final List<String> fcmTokens;
  SendMessageButton(this.messageController, this.wantedUserId,this.fcmTokens);
  final UserSingleton _userSingleton = UserSingleton();
  final FCM _fcm = FCM();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
              backgroundColor: kAccentColor.withOpacity(0.7),
              child: Icon(
                Icons.send_sharp,
                color: Colors.white,
              )),
        ),
        onTap: () {
          if (messageController.text.isNotEmpty) {
            FirebaseFirestore.instance
                .collection('${FirestoreKeyWords.chats}/${_userSingleton.userId}/$wantedUserId')
                .add({
              FirestoreKeyWords.text: messageController.text,
              FirestoreKeyWords.sentAt: Timestamp.now(),
              FirestoreKeyWords.userName: _userSingleton.displayName,
              FirestoreKeyWords.userId: _userSingleton.userId,
            });
            FirebaseFirestore.instance
                .collection('${FirestoreKeyWords.chats}/$wantedUserId/${_userSingleton.userId}')
                .add({
              FirestoreKeyWords.text: messageController.text,
              FirestoreKeyWords.sentAt: Timestamp.now(),
              FirestoreKeyWords.userName:  _userSingleton.displayName,
              FirestoreKeyWords.userId:  _userSingleton.userId,
            });
            FirebaseFirestore.instance.collection('chats').doc(_userSingleton.userId).update({
              wantedUserId : Timestamp.now(),
            });
            FirebaseFirestore.instance.collection('chats').doc(wantedUserId).update({
              _userSingleton.userId : Timestamp.now(),
            });
            if(fcmTokens != null){
              fcmTokens.forEach((element)async{
                await _fcm.pushNotification(sender: UserSingleton().displayName, message: messageController.text, fcm: element);
              });
            }
            messageController.clear();
          }
        },
      ),
    );
  }
}
