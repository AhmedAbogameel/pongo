import 'package:flutter/material.dart';
import '../../constants.dart';

class AltContent extends StatelessWidget {
  final int tabIndex;
  AltContent(this.tabIndex);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          tabIndex == 0
              ? 'assets/images/cat.png'
              : 'assets/images/dog.png',
          height: sizeFromHeight(context, 3),
        ),
        SizedBox(height: 12,),
        Text(
          tabIndex == 1
              ? 'No friends to play with'
              : 'I have kicked those stupid pets',
          // ignore: deprecated_member_use
          style: textTheme.subtitle,
        ),
        SizedBox(
          height: 50,
        ),
        Text(
          'No pets available now',
          // ignore: deprecated_member_use
          style: textTheme.title,
        ),
      ],
    );
  }
}
