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
      theme: theme,
      home: SplashView(),
    );
  }
}
