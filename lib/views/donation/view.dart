import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/views/checkout/view.dart';
import 'package:pet_adoption/views/donation/admob.dart';
import 'package:pet_adoption/views/donation/shimmer_button.dart';
import 'package:pet_adoption/widgets/snack_bar.dart';
import 'my_fatoorah.dart';

class DonationView extends StatefulWidget {
  @override
  _DonationViewState createState() => _DonationViewState();
}

class _DonationViewState extends State<DonationView> {
  AdMob _adMob = AdMob();
  void _initializeVideoAd()async =>await FirebaseAdMob.instance.initialize(appId: _adMob.appId);

  @override
  void initState() {
    _initializeVideoAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: kBGColor,
            // ignore: deprecated_member_use
            title: Text('Donate Us',style: textTheme.subtitle,),
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
              Builder(
                builder: (ctx)=> ShimmerButton(
                  title: 'Watch Ad',
                  isBeta: false,
                  iconData: FontAwesomeIcons.ad,
                  onTap: ()=> showCupertinoDialog(context: context, builder: (_)=> CupertinoAlertDialog(
                    // ignore: deprecated_member_use
                    title: Text('For Success donation!',style: textTheme.subtitle.copyWith(color: Colors.green),),
                    // ignore: deprecated_member_use
                    content: Text('please watch the ad until the end',style: textTheme.body1,),
                    actions: [
                         FlatButton(
                          // ignore: deprecated_member_use
                          child: Text('Donate',style: TextStyle(color: Colors.green),),
                          onPressed: ()async{
                            Navigator.pop(context);
                            bool loaded = await _adMob.showDonationVideo(context);
                            if(!loaded)
                              showSnackBar(ctx, title: 'Failed! Please Try Again', onPressed: (){},label: '');
                          },),
                    ],
                  )),
                ),
              ),
            ],
          ),
        ),
    );
  }
}