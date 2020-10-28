import 'package:pet_adoption/core/models/pet.dart';

class SearchController {

  List<PetModel> allPets = [];

  factory SearchController(){
    return _controller;
  }
  static SearchController _controller = SearchController._();
  SearchController._();
}