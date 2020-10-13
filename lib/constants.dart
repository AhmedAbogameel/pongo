import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String logoLocation = 'assets/images/logo.png';

const Color kPrimaryColor = Color.fromRGBO(170, 180, 190,1);
const Color kAccentColor =  Color.fromRGBO(10, 117, 103,1);

double sizeFromHeight(BuildContext context, double fraction,
    {bool removeAppBarSize = true}) {
  MediaQueryData mediaQuery = MediaQuery.of(context);
  fraction = (removeAppBarSize
      ? (mediaQuery.size.height - AppBar().preferredSize.height - mediaQuery.padding.top)
      : mediaQuery.size.height) /
      (fraction == 0 ? 1 : fraction);
  return fraction;
}

double sizeFromWidth(BuildContext context, double fraction) {
  fraction = MediaQuery.of(context).size.width / (fraction == 0 ? 1 : fraction);
  return fraction;
}