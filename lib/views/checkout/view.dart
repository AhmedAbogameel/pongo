import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/views/checkout/card_model.dart';
import 'package:pet_adoption/views/checkout/circled_button.dart';
import 'package:pet_adoption/views/checkout/donation_dialog.dart';
import 'package:pet_adoption/views/checkout/shimmer_title.dart';
import 'package:pet_adoption/widgets/confirm_button.dart';
import 'package:pet_adoption/widgets/snack_bar.dart';
import 'package:pet_adoption/widgets/text_field.dart';
import 'checkout_controller.dart';

class CheckoutView extends StatefulWidget {
  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _isLoading = false;
  int donationAmount = 1;
  String cvv, cardNumber, expiryMonth, expiryYear;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBGColor,
        title: Text(
          'Checkout',
          // ignore: deprecated_member_use
          style: Theme.of(context).textTheme.subtitle,
        ),
        iconTheme: IconThemeData(color: kAccentColor),
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
          children: [
            ShimmerCheckoutTitle(),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Card Number'),
                        inputField(
                            textInputType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            hint: '42424242424242',
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Invalid Field';
                              else if (value.length < 12)
                                return 'Card Number Must be above 12 number';
                            },
                            onSaved: (value) => cardNumber = value,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CVV'),
                        inputField(
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                            hint: '217',
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Invalid Field';
                              else if (value.length > 3)
                                return 'CVV Must be 3 numbers';
                            },
                            onSaved: (value) => cvv = value),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Expiry Month'),
                      inputField(
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                        hint: '6',
                        validator: (value) {
                          if (value.isEmpty ||
                              int.parse(value) < 1 ||
                              int.parse(value) > 12) return 'Invalid Field';
                        },
                        onSaved: (value) => expiryMonth = value,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Expiry Year'),
                      inputField(
                        textInputType: TextInputType.number,
                        hint: '2025',
                        validator: (value) {
                          if (value.isEmpty) return 'Invalid Field';
                        },
                        onSaved: (value) => expiryYear = value,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: sizeFromHeight(context, 25)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircledButton(
                    isAdd: false,
                    onTap: donationAmount <= 1
                        ? null
                        : () => setState(() => donationAmount--),
                  ),
                  Text(
                    '$donationAmount\$',
                    style: Theme.of(context)
                        .textTheme
                        // ignore: deprecated_member_use
                        .title
                        .copyWith(fontSize: 60),
                  ),
                  CircledButton(
                    isAdd: true,
                    onTap: () => setState(() => donationAmount++),
                  ),
                ],
              ),
            ),
            Builder(
              builder: (ctx) => _isLoading ? Center(child: CupertinoActivityIndicator(),) : ConfirmButton(
                title: 'Donate',
                onPressed: () async {
                  if (_key.currentState.validate()) {
                    setState(()=> _isLoading = true);
                    _key.currentState.save();
                    PaymentCardModel paymentCard = PaymentCardModel(
                      number: cardNumber,
                      expiryMonth: expiryMonth,
                      expiryYear: expiryYear,
                      cvv: cvv,
                    );
                    bool response = await CheckoutController()
                        .makePayment(paymentCard, donationAmount* 100);
                    if (response)
                      showDonationDialog(context);
                    else
                      showSnackBar(ctx,
                          title: 'Invalid Request', onPressed: () {},
                      );
                    setState(()=> _isLoading = false);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}