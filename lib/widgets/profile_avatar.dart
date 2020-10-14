import 'package:flutter/material.dart';
import '../constants.dart';

class ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: kPrimaryColor,
        // backgroundImage: AssetImage(),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
