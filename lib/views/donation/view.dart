import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/views/checkout/view.dart';
import 'package:pet_adoption/views/donation/shimmer_button.dart';
import 'my_fatoorah.dart';

class DonationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: kBGColor,
            title: Text('Donate Us',style: Theme.of(context).textTheme.subtitle,),
            iconTheme: IconThemeData(color: kAccentColor),
          ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ShimmerButton(
                title: 'Checkout',
                iconData: FontAwesomeIcons.solidCreditCard,
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> CheckoutView())),
              ),
              MyFatoorahIntegration(),
              ShimmerButton(
                title: 'Watch Ad',
                isBeta: false,
                iconData: FontAwesomeIcons.ad,
                onTap: (){},
              ),
            ],
          ),
        ),
    );
  }
}