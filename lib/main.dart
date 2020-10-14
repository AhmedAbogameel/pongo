import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/views/splash/view.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
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
      ),
      home: SplashView(),
    );
  }
}
