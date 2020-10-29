import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/widgets/profile_avatar.dart';
import '../../constants.dart';

Widget chatAppBar(BuildContext context){
  final textTheme = Theme.of(context).textTheme;
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 40,
          padding: EdgeInsets.all(1),
          child: Hero(
            tag: '0',
            child: ProfileAvatar(
                'https://alkhabaralyemeni.net/wp-content/uploads/2020/03/image-2-1.jpg'),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kAccentColor,
          ),
        ),
        Text(
          'Chat Name',
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