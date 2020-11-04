import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:url_launcher/url_launcher.dart';

void showAccessDeniedDialog(context) {
  if (!UserSingleton().isPremium)
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: Text(
            'ACCESS DENIED',
            style: TextStyle(color: Colors.red[600]),
          ),
          content: Text('Contact us to have a premium account'),
          actions: [
            FlatButton(
                child: Text(
                  'Contact',
                ),
                textColor: Colors.green,
                onPressed: () async => await _launchURL('mailto:gamilco81@gmail.com?subject=Premium Account for Pongo&body='''),
            ),
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        ),
    );
}

Future<void> _launchURL(appUrl) async {
  if (await canLaunch(appUrl)) {
    await launch(appUrl);
  }
}