import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/views/menu/menu_frame.dart';
import '../../constants.dart';

void showDonationDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => CupertinoAlertDialog(
      title: Icon(
        Icons.cloud_done_rounded,
        color: kAccentColor,
        size: 50,
      ),
      content: Text('Thank You for your donation'),
      actions: [
        FlatButton(
          child: Text('Go Home'),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => MenuFrame(),
            ),
          ),
        ),
      ],
    ),
  );
}