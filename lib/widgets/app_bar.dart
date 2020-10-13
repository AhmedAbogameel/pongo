import 'package:flutter/material.dart';

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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/logo.png'),
        ),
      )
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