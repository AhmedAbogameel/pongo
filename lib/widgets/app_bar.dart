import 'package:flutter/material.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:pet_adoption/widgets/profile_avatar.dart';

Widget appBar(Function menuCallBack){
  return  AppBar(
    elevation: 0.0,
    title: Column(
      children: [
        Text('Location',style: TextStyle(fontSize: 15,color: kAccentColor),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on,color: kAccentColor,),
            Text('Egypt',style: TextStyle(fontWeight: FontWeight.w900,color: kAccentColor),),
          ],
        )
      ],
    ),
    actions: [
      UserSingleton().photoUrl != null ?
        ProfileAvatar(UserSingleton().photoUrl) : CircleAvatar(radius: 25,backgroundColor: kBGColor,),
    ],
    backgroundColor: Colors.transparent,
    leading: IconButton(
      icon: Icon(
        Icons.menu,
        color: Colors.black,
      ),
      onPressed: menuCallBack,
    ),
  );
}