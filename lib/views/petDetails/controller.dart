import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:pet_adoption/core/models/pet.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:http/http.dart' as http;

class FavouriteController {

  final url = 'https://pongoo.firebaseio.com/users/${UserModel().userId}/myFavourite.json';

  Future<void> addFavourite(PetModel petModel)async{
    await http.post(url,body: jsonEncode(petModel.toJson()));
  }

  Future<void> removeFavourite(PetModel petModel)async{
    final response = await http.get(url);
    final decodedResponse = jsonDecode(response.body);
    if(decodedResponse != null){
      String petKey;
      decodedResponse.forEach((key,value){
        if(mapEquals(value, petModel.toJson())){
          petKey = key;
        }
      });
      await http.delete('https://pongoo.firebaseio.com/users/${UserModel().userId}/myFavourite/$petKey.json');
    }
  }

  Future<bool> checkFavourite(PetModel petModel)async{
    final response = await http.get(url);
    final decodedResponse = jsonDecode(response.body);
    List myFavourite = [];
    if(decodedResponse != null){
      decodedResponse.forEach((key,value){
        myFavourite.add(value);
      });
    }
    bool isFavourite = false;
    myFavourite.forEach((element) {
      if(mapEquals(element, petModel.toJson())){
        isFavourite = true;
      }
    });
    return isFavourite;
  }

}