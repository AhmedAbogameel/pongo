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
            colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.dstATop),
            image: NetworkImage(
                'https://i.pinimg.com/originals/ca/cb/fc/cacbfcff3d9472212d9c3ffbb4085ced.jpg'),
            fit: BoxFit.cover,
        ),
      ),
    );
  }
}
