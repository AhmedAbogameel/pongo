import 'package:flutter/material.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/views/splash/view.dart';

main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        primaryColor: kPrimaryColor,
        accentColor: kAccentColor,
        fontFamily: 'Tajawal',
      ),
      home: SplashView(),
    );
  }
}

