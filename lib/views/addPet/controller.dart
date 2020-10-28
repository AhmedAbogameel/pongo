import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_adoption/core/models/pet.dart';

class AddPetController {

  Future<String> addPet(String path, PetModel petModel,) async{
    final url = 'https://pongoo.firebaseio.com/pets/$path.json';
    try{
      await http.post(url,body: jsonEncode(petModel.toJson()));
      return 'Done';
    }catch(_){
      return 'Failed';
    }
  }

}