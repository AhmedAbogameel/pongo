import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:pet_adoption/core/keywords/api.dart';
import 'package:pet_adoption/core/models/pet.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:http/http.dart' as http;

class FavouriteController {

  final _url = 'https://pongoo.firebaseio.com/users/${UserSingleton().userId}/${PetKeywords.myFavourite}.json';

  Future<void> addFavourite(PetModel petModel)async => await http.post(_url,body: jsonEncode(petModel.toJson()));

  Future<void> removeFavourite(PetModel petModel)async{
    final response = await http.get(_url);
    final decodedResponse = jsonDecode(response.body);
    if(decodedResponse != null){
      String petKey;
      decodedResponse.forEach((key,value){
        if(mapEquals(value, petModel.toJson())){
          petKey = key;
        }
      });
      await http.delete('https://pongoo.firebaseio.com/users/${UserSingleton().userId}/${PetKeywords.myFavourite}/$petKey.json');
    }
  }

  Future<bool> checkFavourite(PetModel petModel)async{
    final response = await http.get(_url);
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

  Future<void> deletePet(PetModel petModel)async{
    String path = petModel.isCat ? 'cats' : 'dogs';
    final response = await http.get('https://pongoo.firebaseio.com/pets/$path.json');
    final decodedResponse = jsonDecode(response.body);
    if(decodedResponse != null){
      String petKey;
      decodedResponse.forEach((key,value){
        if(mapEquals(value, petModel.toJson())){
          petKey = key;
        }
      });
      await http.delete('https://pongoo.firebaseio.com/pets/$path/$petKey.json');
    }
    final _adoptionUrl = 'https://pongoo.firebaseio.com/users/${UserSingleton().userId}/${PetKeywords.myAdoption}.json';
    final adoptionResponse = await http.get(_adoptionUrl);
    final decodedAdoptionResponse = jsonDecode(adoptionResponse.body);
    if(decodedAdoptionResponse != null){
      String petKey;
      decodedAdoptionResponse.forEach((key,value){
        if(mapEquals(value, petModel.toJson())){
          petKey = key;
        }
      });
      await http.delete('https://pongoo.firebaseio.com/users/${UserSingleton().userId}/${PetKeywords.myAdoption}/$petKey.json');
    }
  }

}