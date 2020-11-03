import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pet_adoption/views/login/view.dart';
import '../../constants.dart';

class OnBoardingImage extends StatelessWidget {
  final String imageName;
  final bool getStarted;
  final int position;
  OnBoardingImage(this.imageName,{this.getStarted = false,this.position});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(bottom: sizeFromHeight(context, 15,removeAppBarSize: false)),
        child: getStarted ? AnimationConfiguration.staggeredList(
            position: position,
            duration: Duration(seconds: 2),
            delay: Duration(seconds: 1),
            child: FadeInAnimation(
              child: OutlineButton(
                borderSide: BorderSide(color: kBGColor,width: 2),
                splashColor: kAccentColor,
                highlightedBorderColor: kAccentColor,
                textColor: kBGColor,
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 30),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Text('Get Started!',style: TextStyle(fontWeight: FontWeight.bold),),
                onPressed: ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> LoginView())),
              ),
            )
        ) : Container(),
      ),
      alignment: Alignment.bottomCenter,
      height: sizeFromHeight(context, 1, removeAppBarSize: false),
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
          image: AssetImage('assets/images/onBoarding/$imageName.jpg')
        )
      ),
    );
  }
}