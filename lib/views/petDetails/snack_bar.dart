import 'package:flutter/material.dart';
import '../../constants.dart';

void showSnackBar(ctx, {@required title, @required onPressed}) {
  Scaffold.of(ctx).hideCurrentSnackBar();
  Scaffold.of(ctx).showSnackBar(
    SnackBar(
      content: Text(
        title,
        // ignore: deprecated_member_use
        style: Theme.of(ctx).textTheme.subtitle,
      ),
      backgroundColor: kBGColor,
      elevation: 5,
      action: SnackBarAction(
        label: 'Undo',
        textColor: kAccentColor,
        onPressed: onPressed,
      ),
    ),
  );
}
