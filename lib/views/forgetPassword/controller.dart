import 'dart:convert';
import 'package:http/http.dart' as http;

class ForgetPasswordController {
  final String _apiKey = 'AIzaSyCMEFcYYsswdlK5hVOmn_PsPjw1cDjN9Vc';

  Future<String> resetPassword(String email)async{
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=$_apiKey';

    Map<String, String> body = {
      'requestType':'PASSWORD_RESET',
      'email':email
    };

    final response = await http.post(url,body: jsonEncode(body));

    try{
      final decodedResponse = jsonDecode(response.body);
      return decodedResponse['error']['message'].replaceAll('_', ' ');
    }catch (_){
      return 'Check email for Reset Password !';
    }
  }
}