import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/core/keywords/firestore.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'message_bubble.dart';

class MessagesList extends StatelessWidget {
  MessagesList(this.wantedUserId);
  final String wantedUserId;
  final UserSingleton _userSingleton = UserSingleton();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('${FirestoreKeyWords.chats}/${_userSingleton.userId}/$wantedUserId')
            .orderBy('sentAt', descending: true)
            .snapshots(),
        builder: (_, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting)
            return Center(
              child: CupertinoActivityIndicator(),
            );
          final List docs = snapShot.data.docs;
          return ListView.builder(
            itemCount: docs.length,
            reverse: true,
            itemBuilder: (_, listIndex) => MessageBubble(
              isMe: docs[listIndex][FirestoreKeyWords.userId] == _userSingleton.userId,
              key: ValueKey(docs[listIndex][FirestoreKeyWords.userId]),
              message: docs[listIndex][FirestoreKeyWords.text],
              userName: docs[listIndex][FirestoreKeyWords.userName],
              timestamp: docs[listIndex]['sentAt'],
            ),
          );
        },
      ),
    );
  }
}
