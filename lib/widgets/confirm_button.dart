import 'package:flutter/material.dart';

import '../constants.dart';

class ConfirmButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  ConfirmButton({@required this.onPressed,this.title = 'Confirm'});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      height: 50,
      child: RaisedButton(
        child: Text(title),
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
