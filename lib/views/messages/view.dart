import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/core/keywords/firestore.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:pet_adoption/views/messages/chat_tile.dart';

class MessagesView extends StatelessWidget {
  List<String> allUsers = [];
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        // ignore: deprecated_member_use
        title: Text('Messages',style: textTheme.subtitle,),
        backgroundColor: kBGColor,
        iconTheme: IconThemeData(color: kAccentColor),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('chats').doc(UserSingleton().userId).snapshots(),
        builder: (_, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting)
            return Center(
              child: CupertinoActivityIndicator(),
            );
          allUsers.clear();
          snapShot.data.data().forEach((key, value){
            allUsers.add(key);
          });
          allUsers.reversed;
          return AnimationLimiter(
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
              itemCount: allUsers.length,
              itemBuilder: (_, listIndex) => AnimationConfiguration.staggeredList(
                position: listIndex,
                duration: const Duration(seconds: 1),
                child: SlideAnimation(
                  verticalOffset: 100.0,
                  child: FadeInAnimation(
                    child: ChatTile(allUsers[listIndex]),
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}