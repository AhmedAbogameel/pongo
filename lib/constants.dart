import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String logoLocation = 'assets/images/logo.png';

const Color kPrimaryColor = Color.fromRGBO(189, 200, 204, 1);
const Color kAccentColor = Color.fromRGBO(56, 97, 96, 1);
const Color kBGColor = Color.fromRGBO(244, 244, 244, 1);

void hideStatusBar()=> SystemChrome.setEnabledSystemUIOverlays([]);

final ThemeData theme = ThemeData(
  platform: TargetPlatform.iOS,
  primaryColor: kPrimaryColor,
  accentColor: kAccentColor,
  canvasColor: kBGColor,
  fontFamily: 'Tajawal',
  textTheme: TextTheme(
// ignore: deprecated_member_use
    title: TextStyle(
      color: kAccentColor,
      fontSize: 25,
      fontWeight: FontWeight.w900,
    ),
// ignore: deprecated_member_use
    subtitle: TextStyle(
      color: kAccentColor.withOpacity(0.5),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
// ignore: deprecated_member_use
    body1: TextStyle(
      color: kAccentColor.withOpacity(0.8),
      fontSize: 15,
    ),
  ),
);

double sizeFromHeight(BuildContext context, double fraction,
    {bool removeAppBarSize = true}) {
  MediaQueryData mediaQuery = MediaQuery.of(context);
  fraction = (removeAppBarSize
          ? (mediaQuery.size.height -
              AppBar().preferredSize.height -
              mediaQuery.padding.top)
          : mediaQuery.size.height) /
      (fraction == 0 ? 1 : fraction);
  return fraction;
}

double sizeFromWidth(BuildContext context, double fraction) {
  fraction = MediaQuery.of(context).size.width / (fraction == 0 ? 1 : fraction);
  return fraction;
}
