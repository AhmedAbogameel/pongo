import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants.dart';

class ShimmerCheckoutTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Shimmer.fromColors(
        baseColor: kAccentColor,
        highlightColor: kPrimaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(FontAwesomeIcons.solidCreditCard, size: 40,),
            SizedBox(width: 15),
            Text('Checkout',style: TextStyle(fontSize: 60,fontWeight: FontWeight.w900),),
          ],
        ),
      ),
    );
  }
}