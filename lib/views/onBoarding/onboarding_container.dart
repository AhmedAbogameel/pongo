import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pet_adoption/views/login/view.dart';
import '../../constants.dart';

class OnBoardingContainer extends StatelessWidget {
  final Color color;
  final String image;
  final bool isFinalPage;
  final String text;
  OnBoardingContainer(
      {@required this.image,
      @required this.color,
      this.isFinalPage = false,
      @required this.text,
      });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(context, 1, removeAppBarSize: false),
      width: double.infinity,
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('assets/images/onBoarding/$image.png'),
          // ignore: deprecated_member_use
          !isFinalPage
              ? Text(
                  text,
                  // ignore: deprecated_member_use
                  style: Theme.of(context).textTheme.title.copyWith(color: color==kAccentColor ? kBGColor : kAccentColor),
                  textAlign: TextAlign.center,
                )
              : AnimationConfiguration.staggeredList(
                  position: 2,
                  duration: Duration(seconds: 2),
                  child: FadeInAnimation(
                    child: OutlineButton(
                      borderSide: BorderSide(color: kBGColor, width: 2),
                      splashColor: kAccentColor,
                      highlightedBorderColor: kAccentColor,
                      textColor: kBGColor,
                      padding: EdgeInsets.symmetric(
                          vertical: 20, horizontal: sizeFromWidth(context, 4)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Let\'s Get Started!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => LoginView())),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}