import 'package:flutter/material.dart';
import 'package:pet_adoption/widgets/profile_avatar.dart';

Widget appBar(Function menuCallBack){
  return  AppBar(
    elevation: 0.0,
    title: Column(
      children: [
        Text('Location',style: TextStyle(fontSize: 15),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on),
            Text('Egypt',style: TextStyle(fontWeight: FontWeight.w900),),
          ],
        )
      ],
    ),
    actions: [
      ProfileAvatar(),
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