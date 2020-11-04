import 'package:flutter/cupertino.dart';

class PaymentCardModel {

  String number, expiryMonth, expiryYear,cvv;

  PaymentCardModel({
    @required this.cvv,
    @required this.number,
    @required this.expiryMonth,
    @required this.expiryYear,
  });

}
