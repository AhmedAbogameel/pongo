import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_adoption/core/models/user_model.dart';
import 'package:pet_adoption/core/services/get_user_by_uid.dart';
import 'package:pet_adoption/widgets/profile_avatar.dart';
import '../../constants.dart';

class OwnerTile extends StatefulWidget {
  final String userId;
  final int timestamp;
  OwnerTile(this.userId, this.timestamp);
  @override
  _OwnerTileState createState() => _OwnerTileState();
}

class _OwnerTileState extends State<OwnerTile> {
  UserModel _userModel;
  bool _isLoading = true;

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  void _getUser() async {
    _userModel = await getUserByUID(widget.userId);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateTime publishAt = DateTime.fromMillisecondsSinceEpoch(widget.timestamp);
    return _isLoading
        ? Center(
            child: CupertinoActivityIndicator(),
          )
        : ListTile(
            leading: ProfileAvatar(_userModel.photoUrl),
            // ignore: deprecated_member_use
            title: Text(_userModel.displayName,
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.title, softWrap: true),
            // ignore: deprecated_member_use
            subtitle: Text(
              'Owner',
              // ignore: deprecated_member_use
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Padding(
              padding: EdgeInsets.only(right: sizeFromWidth(context, 10)),
              // ignore: deprecated_member_use
              child: Text(
                '${DateFormat.yMMMd().format(publishAt)}',
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.body1,
              ),
            ),
          );
  }
}