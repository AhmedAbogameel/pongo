import 'package:flutter/material.dart';
import '../../constants.dart';

void showSnackBar(ctx, {@required title, @required onPressed}) {
  Scaffold.of(ctx).hideCurrentSnackBar();
  Scaffold.of(ctx).showSnackBar(
    SnackBar(
      content: Text(
        title,
        style: Theme.of(ctx).textTheme.subtitle,
      ),
      backgroundColor: kBGColor,
      elevation: 5,
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      action: SnackBarAction(
        label: 'Undo',
        textColor: kAccentColor,
        onPressed: onPressed,
      ),
    ),
  );
}
