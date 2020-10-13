import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/views/home/view.dart';
import 'package:pet_adoption/widgets/menu_frame.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    Timer(
      Duration(seconds: 3),
        ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> MenuFrame()))
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeInImage(
          fadeInDuration: Duration(milliseconds: 500),
          fadeOutDuration: Duration(milliseconds: 500),
          fadeInCurve: Curves.easeInSine,
          fadeOutCurve: Curves.easeOutSine,
          placeholder: AssetImage(logoLocation),
          image: AssetImage(logoLocation),
        ),
      ),
    );
  }
}
