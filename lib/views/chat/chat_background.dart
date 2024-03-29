import 'package:flutter/material.dart';
import '../../constants.dart';

class ChatBackground extends StatelessWidget {
  final Widget child;
  ChatBackground({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
        image: DecorationImage(
            colorFilter: ColorFilter.mode(kAccentColor, BlendMode.color),
            image: AssetImage('assets/images/chatBG.jpg'),
            // NetworkImage(
            //   'https://i.pinimg.com/564x/92/2e/52/922e52869305a8eec5a96f421725b353.jpg',
            //     // 'https://i.pinimg.com/originals/ca/cb/fc/cacbfcff3d9472212d9c3ffbb4085ced.jpg',
            // ),
            fit: BoxFit.cover,
        ),
      ),
    );
  }
}