import 'package:flutter/material.dart';
import '../constants.dart';

void showSnackBar(ctx, {@required title, @required onPressed , String label = 'Undo'}) {
  Scaffold.of(ctx).hideCurrentSnackBar();
  Scaffold.of(ctx).showSnackBar(
    SnackBar(
      content: Text(
        title,
        // ignore: deprecated_member_use
        style: Theme.of(ctx).textTheme.subtitle.copyWith(
          color: label == 'Undo' ? kAccentColor.withOpacity(0.5) : kBGColor
        ),
      ),
      backgroundColor: label == 'Undo' ? kBGColor : kAccentColor,
      elevation: 5,
      action: SnackBarAction(
        label: label,
        textColor: label == 'Undo' ? kAccentColor : kBGColor,
        onPressed: onPressed,
      ),
    ),
  );
}
