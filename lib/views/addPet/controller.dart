import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:pet_adoption/core/keywords/api.dart';
import 'package:pet_adoption/core/models/pet.dart';
import 'package:pet_adoption/core/models/user.dart';

class AddPetController {

  Future<String> addPet(String path, PetModel petModel,) async{
    final url = 'https://pongoo.firebaseio.com/pets/$path.json';
    final adoptionUrl = 'https://pongoo.firebaseio.com/users/${UserSingleton().userId}/${PetKeywords.myAdoption}.json';
    try{
      await http.post(url,body: jsonEncode(petModel.toJson()));
      await http.post(adoptionUrl,body: jsonEncode(petModel.toJson()));
      return 'Done';
    }catch(_){
      return 'Failed';
    }
  }

  Future removeBG(File imageFile)async{
    final apiKeyResponse = await http.get('https://pongoo.firebaseio.com/keys/removeBG.json');
    final String apiKey = jsonDecode(apiKeyResponse.body);
    Map<String,String> headers = {'X-Api-Key': apiKey};
    Map<String,String> body = {
      'crop':'true',
      'format':'png',
      'size' : 'auto',
      'position':'center'
    };
    const url = 'https://api.remove.bg/v1.0/removebg';
    var stream = new http.ByteStream(imageFile.openRead());
    var length = await imageFile.length();
    var uri = Uri.parse(url);
    var request = new http.MultipartRequest("POST", uri,);
    request.fields.addAll(body);
    request.headers.addAll(headers);
    var multipartFile = new http.MultipartFile('image_file', stream, length,
        filename: Timestamp.now().millisecondsSinceEpoch.toString());
    request.files.add(multipartFile);
    var response = await request.send();
    if(response.statusCode == 200){
      var uInt8List;
      await response.stream.toBytes().asStream().listen((value)=> uInt8List = value).asFuture();
      return uInt8List;
    }else{
      return null;
    }
  }

}