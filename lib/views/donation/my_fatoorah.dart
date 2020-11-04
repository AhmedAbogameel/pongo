import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:pet_adoption/views/donation/shimmer_button.dart';

class MyFatoorahIntegration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShimmerButton(
      title: 'My Fatoorah',
      iconData: FontAwesomeIcons.solidCreditCard,
      onTap: () {
        MyFatoorah.startPayment(
          context: context,
          errorChild: Center(
            child: Icon(
              Icons.error,
              color: Colors.redAccent,
              size: 50,
            ),
          ),
          succcessChild: Center(
            child: Icon(
              Icons.done_all,
              color: Colors.greenAccent,
              size: 50,
            ),
          ),
          request: MyfatoorahRequest(
            currencyIso: Country.SaudiArabia,
            successUrl:
            "https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png",
            errorUrl:
            "https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png",
            invoiceAmount: 100,
            language: ApiLanguage.Arabic,
            token: null,
          ),
        ).then((response) {
          print(response);
        }).catchError((e) {
          print(e);
        });
      },
    );
  }
}