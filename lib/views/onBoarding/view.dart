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
        positionSlideIcon: 0.35,
        slideIconWidget: Icon(
          Icons.arrow_forward_ios_outlined,
          color: pageIndex == 0 ? kBGColor : kAccentColor,
        ),
        enableSlideIcon: pageIndex != 3,
        onPageChangeCallback: (int pageIndex) =>
            setState(() => this.pageIndex = pageIndex),
        pages: [
          OnBoardingContainer(
            color: kAccentColor,
            text: 'Search for a new friend',
            image: 'cuteCat',
          ),
          OnBoardingContainer(
            color: kBGColor,
            text: 'Post your pet for adoption',
            image: 'sweetyDog',
          ),
          OnBoardingContainer(
            color: kPrimaryColor,
            text: 'Message owner to make a deal with.',
            image: 'cuteBulldog',
          ),
          OnBoardingContainer(
            color: kAccentColor,
            text: 'Adopt Me',
            image: 'adoptPet',
            isFinalPage: true,
          ),
        ],
      ),
    );
  }
}