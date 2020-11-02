import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/core/keywords/firestore.dart';
import 'package:pet_adoption/core/models/user.dart';
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
      ],
    ),
    leading: Row(
      children: [
        IconButton(icon: Icon(Icons.arrow_back_ios_outlined), onPressed: ()async{
          await Future.delayed(Duration.zero,()=> FocusScope.of(context).unfocus());
          Navigator.pop(context);
        })
      ],
    ),
    backgroundColor: kBGColor,
    iconTheme: IconThemeData(color: kAccentColor),
  );
}