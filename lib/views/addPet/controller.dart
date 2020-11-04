import 'dart:convert';
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

}