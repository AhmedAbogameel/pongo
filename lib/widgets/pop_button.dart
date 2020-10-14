import 'package:flutter/material.dart';
import 'package:pet_adoption/constants.dart';

class PopButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 15,
      top: 15,
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: kBGColor,
          size: 30,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}