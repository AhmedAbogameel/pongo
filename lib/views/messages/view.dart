import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/core/keywords/firestore.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:pet_adoption/views/messages/alternative_chats_tile.dart';
import 'package:pet_adoption/views/messages/chat_tile.dart';

import 'list_view.dart';

class MessagesView extends StatelessWidget {
  List<String> allUsers = [];
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Messages',
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
              snapShot.data.data().keys.forEach((key) {
                allUsers.add(key);
              });
            }
            allUsers.reversed;
            return snapShot.data.data() == null
                ? AlternativeChatsTile()
                : ChatsTileList(allUsers);
          },
        ));
  }
}