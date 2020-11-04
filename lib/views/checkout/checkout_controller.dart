import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_adoption/views/checkout/card_model.dart';

class CheckoutController {

  static const String _tokenUrl = 'https://api.sandbox.checkout.com/tokens';
  static const String _paymentUrl = 'https://api.sandbox.checkout.com/payments';

  static const String _secretKey = 'sk_test_665eadc5-6cb2-454a-b536-0fa22afb9bc1';
  static const String _publicKey = 'pk_test_6a692bcb-040c-4fb6-b5fa-eb6ebdf6982f';
  
  static const Map<String, String> _tokenHeaders = {
    'Content-Type' : 'Application/json',
    'Authorization' : _publicKey,
  };

  static const Map<String, String> _paymentHeaders = {
    'Content-Type' : 'Application/json',
    'Authorization' : _secretKey,
  };

  Future<String> _getToken(PaymentCardModel paymentCard)async{
    Map<String,String> body = {
      'type' : 'card',
      'number' : paymentCard.number,
      'expiry_month' : paymentCard.expiryMonth,
      'expiry_year' : paymentCard.expiryYear,
    };
    final http.Response response = await http.post(_tokenUrl, headers: _tokenHeaders, body: jsonEncode(body));
    switch(response.statusCode){
      case 201:
        final decodedResponse = jsonDecode(response.body);
        return decodedResponse['token'];
        break;
      default:
        return 'Card Invalid';
        break;
    }
  }

  Future<bool> makePayment(PaymentCardModel paymentCard,int amount)async{
    String token = await _getToken(paymentCard);
    if(token == 'Card Invalid')
      return false;
    Map<String, dynamic> body = {
      'source' : {
        'type' : 'token',
        'token' : token,
      },
      'amount' : amount,
      'currency' : 'USD',
    };
    final http.Response response = await http.post(_paymentUrl, headers: _paymentHeaders, body: jsonEncode(body));
    switch(response.statusCode){
      case 201:
        return true;
        break;
      default:
        return false;
        break;
    }
  }
}