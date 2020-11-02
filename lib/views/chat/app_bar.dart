import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/core/models/user_model.dart';
import 'package:pet_adoption/widgets/profile_avatar.dart';
import '../../constants.dart';

Widget chatAppBar(BuildContext context,UserModel user){
  final textTheme = Theme.of(context).textTheme;
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 40,
          padding: EdgeInsets.all(1),
          child: Hero(
            tag: user.photoUrl,
            child: ProfileAvatar(
                user.photoUrl,
            ),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kAccentColor,
          ),
        ),
        Text(
          user.displayName,
          // ignore: deprecated_member_use
          style: textTheme.body1,
        ),
        Spacer(),
        IconButton(
          icon: Icon(FontAwesomeIcons.windowClose,
              color: kAccentColor.withOpacity(0.6)),
          onPressed: () {},
        ),
      ],
    ),
    backgroundColor: kBGColor,
    iconTheme: IconThemeData(color: kAccentColor),
  );
}