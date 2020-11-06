import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_adoption/core/keywords/api.dart';
import 'package:pet_adoption/core/models/pet.dart';

class HomeController {
  Future<List<PetModel>> getPets(String base)async{
    final url = 'https://pongoo.firebaseio.com/$base.json';
    List<PetModel> _pets = [];
    final response = await http.get(url);
    final decodedResponse = jsonDecode(response.body);
    if(response.statusCode == 200){
      if(decodedResponse != null)
      decodedResponse.forEach((_ , value)=> _pets.add(PetModel.fromJson(value)));
    }
    _pets.sort((a,b)=> b.toJson()[PetKeywords.publishAt].compareTo(a.toJson()[PetKeywords.publishAt]));
    return _pets;
  }
}