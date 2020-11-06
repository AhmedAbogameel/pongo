import 'package:flutter/material.dart';
import '../../constants.dart';

class AlternativeChatsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.supervised_user_circle_sharp,
            color: kAccentColor.withOpacity(0.7),
            size: sizeFromHeight(context, 5),
          ),
          Text(
            'No Owners to deal with',
            // ignore: deprecated_member_use
            style: Theme.of(context).textTheme.subtitle,
          ),
        ],
      ),
    );
  }
}
