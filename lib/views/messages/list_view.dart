import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'chat_tile.dart';

class ChatsTileList extends StatelessWidget {
  final List<String> allUsers;
  ChatsTileList(this.allUsers);
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
        itemCount: allUsers.length,
        itemBuilder: (_, listIndex) =>
            AnimationConfiguration.staggeredList(
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
  }
}
