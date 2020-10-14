import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';

class PetInfoContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: sizeFromHeight(context,8),
        padding: EdgeInsets.symmetric(horizontal: 30),
        margin: EdgeInsets.symmetric(horizontal: sizeFromWidth(context, 7)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ignore: deprecated_member_use
                Text('Sala',style: Theme.of(context).textTheme.title,),
                Icon(FontAwesomeIcons.mars,color: kAccentColor,size: 30,)
              ],
            ),
            SizedBox(height: 15 ,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ignore: deprecated_member_use
                Text('Apyssinian cat',style: Theme.of(context).textTheme.subtitle,),
                // ignore: deprecated_member_use
                Text('2 years old',style: Theme.of(context).textTheme.body1,),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          boxShadow: [BoxShadow(color: kPrimaryColor,blurRadius: 15)],
          color: Colors.white,
        ),
      ),
    );
  }
}
