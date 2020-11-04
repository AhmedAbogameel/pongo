import 'dart:async';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pet_adoption/views/onBoarding/onboarding_image.dart';

class OnBoardingView extends StatefulWidget {
  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  LiquidController _liquidController = LiquidController();
  int pageIndex = 0;
  int position = 0;
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      pageIndex++;
      _liquidController.animateToPage(page: pageIndex, duration: 1500);
      if (pageIndex == 2) {
        setState(() => position = 1);
        timer.cancel();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        enableLoop: false,
        fullTransitionValue: 750,
        liquidController: _liquidController,
        ignoreUserGestureWhileAnimating: true,
        pages: [
          OnBoardingImage('firstPage'),
          OnBoardingImage('secondPage'),
          OnBoardingImage(
            'thirdPage',
            getStarted: true,
            position: position,
          ),
        ],
      ),
    );
  }
}