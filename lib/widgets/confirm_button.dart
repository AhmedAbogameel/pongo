import 'package:flutter/material.dart';

import '../constants.dart';

class ConfirmButton extends StatelessWidget {
  final Function onPressed;
  ConfirmButton({@required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      height: 50,
      child: RaisedButton(
        child: Text('Confirm'),
        color: kAccentColor,
        colorBrightness: Brightness.dark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
