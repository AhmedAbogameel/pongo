import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/core/keywords/firestore.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:pet_adoption/views/messages/alternative_chats_tile.dart';
import 'list_view.dart';

// ignore: must_be_immutable
class MessagesView extends StatelessWidget {
  List<String> allUsers = [];
  List usersTimeStamps = [];
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Messages',
            // ignore: deprecated_member_use
            style: textTheme.subtitle,
          ),
          backgroundColor: kBGColor,
          iconTheme: IconThemeData(color: kAccentColor),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection(FirestoreKeyWords.chats)
              .doc(UserSingleton().userId)
              .snapshots(),
          builder: (_, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting)
              return Center(
                child: CupertinoActivityIndicator(),
              );
            allUsers.clear();
            if (snapShot.data.data() != null) {
              Map dataSnapShots = snapShot.data.data();
              usersTimeStamps = dataSnapShots.values.toList();
              usersTimeStamps.sort((a,b)=> b.millisecondsSinceEpoch.compareTo(a.millisecondsSinceEpoch));
              usersTimeStamps.forEach((element) {
                dataSnapShots.forEach((key, value) {
                  if(value.millisecondsSinceEpoch == element.millisecondsSinceEpoch)
                    allUsers.add(key);
                });
              });
            }
            return snapShot.data.data() == null
                ? AlternativeChatsTile()
                : ChatsTileList(allUsers,usersTimeStamps);
          },
        ));
  }
}