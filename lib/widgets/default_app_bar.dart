import 'package:flutter/material.dart';
import '../constants.dart';

Widget defaultAppBar (context,{@required String title}){
  return AppBar(
    iconTheme: IconThemeData(color: kAccentColor,size: 30),
    centerTitle: true,
    backgroundColor: kBGColor,
    title: Text(
      title,
      // ignore: deprecated_member_use
      style: Theme.of(context).textTheme.title,
    ),
  );
}