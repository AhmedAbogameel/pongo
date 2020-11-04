import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/views/onBoarding/onboarding_container.dart';

class OnBoardingView extends StatefulWidget {
  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  LiquidController _liquidController = LiquidController();
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        enableLoop: false,
        fullTransitionValue: 750,
        liquidController: _liquidController,
        ignoreUserGestureWhileAnimating: true,
        enableSlideIcon: pageIndex != 2,
        onPageChangeCallback: (int pageIndex) =>
            setState(() => this.pageIndex = pageIndex),
        pages: [
          OnBoardingContainer(
            color: kBGColor,
            text: 'Adopt Me',
            imagePath: logoLocation,
          ),
          OnBoardingContainer(
            color: kPrimaryColor,
            text: 'Adopt Me',
            imagePath: logoLocation,
          ),
          OnBoardingContainer(
            color: kAccentColor,
            text: 'Adopt Me',
            imagePath: logoLocation,
            isFinalPage: true,
          ),
        ],
      ),
    );
  }
}