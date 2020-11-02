import 'package:flutter/material.dart';
import 'package:pet_adoption/core/models/user_model.dart';
import 'package:pet_adoption/core/services/get_user_by_uid.dart';
import 'package:pet_adoption/views/chat/view.dart';
import 'package:pet_adoption/views/messages/shimmer_tile.dart';
import '../../constants.dart';

class ChatTile extends StatefulWidget {
  final String wantedUserId;
  ChatTile(this.wantedUserId);
  @override
  _ChatTileState createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  UserModel _userModel = UserModel();
  bool _isLoading = true;
  void _getUser() async {
    _userModel = await getUserByUID(widget.wantedUserId);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return _isLoading
        ? ShimmerTile()
        : InkWell(
          splashColor: kAccentColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          child: Card(
            color: kBGColor,
            margin: EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Row(
                children: [
                  Hero(
                    tag: _userModel.photoUrl,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: kBGColor,
                      backgroundImage: NetworkImage(_userModel.photoUrl),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: Text(
                      _userModel.displayName,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: textTheme.title.copyWith(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => ChatView(_userModel))),
        );
  }
}
/*
 direction: DismissDirection.endToStart,
            onDismissed: (_) {},
            key: ValueKey(_userModel.userId),
 */