import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pet_adoption/constants.dart';

class OnBoardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        enableLoop: false,
        enableSlideIcon: true,
        fullTransitionValue: 500,
        ignoreUserGestureWhileAnimating: true,
        pages: [
          Container(
            width: double.infinity,
            height: sizeFromHeight(context, 1, removeAppBarSize: false),
            color: Colors.red,
            child: Text('a'),
          ),
          Container(
            width: double.infinity,
            height: sizeFromHeight(context, 1, removeAppBarSize: false),
            color: Colors.green,
            child: Text('b'),
          ),
          Container(
            width: double.infinity,
            height: sizeFromHeight(context, 1, removeAppBarSize: false),
            color: Colors.yellow,
            child: Text('c'),
          ),
        ],
      ),
    );
  }
}
