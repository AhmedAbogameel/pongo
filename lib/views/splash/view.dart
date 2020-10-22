import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:pet_adoption/views/login/view.dart';
import 'package:pet_adoption/views/menu/menu_frame.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => UserModel().userId == null ? LoginView() : MenuFrame(),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAccentColor,
      body: Center(
        child: FadeInImage(
          fadeInDuration: Duration(milliseconds: 1000),
          fadeOutDuration: Duration(milliseconds: 1000),
          fadeInCurve: Curves.easeInSine,
          fadeOutCurve: Curves.easeOutSine,
          placeholder: AssetImage(logoLocation),
          image: AssetImage(logoLocation),
        ),
      ),
    );
  }
}
