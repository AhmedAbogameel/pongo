import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/core/models/pet.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:pet_adoption/views/home/alt_content.dart';
import 'package:pet_adoption/views/home/controller.dart';
import 'package:pet_adoption/widgets/animated_list_view.dart';
import 'package:pet_adoption/widgets/default_app_bar.dart';

class FavouriteView extends StatefulWidget {
  @override
  _FavouriteViewState createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {

  bool _isLoading = true;
  List<PetModel> _pets;
  HomeController _homeController = HomeController();
  int randomNumber;

  @override
  void initState() {
    randomNumber = Random().nextInt(2);
    super.initState();
    _getPets();
  }

  Future<void> _getPets() async {
    UserModel _user = UserModel();
    _pets = await _homeController.getPets('users/${_user.userId}/myFavourite');
    setState(() {
      _isLoading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _getPets,
      child: Scaffold(
        appBar: defaultAppBar(context,title: 'My Favourite List'),
        body: _isLoading
            ? Center(
          child: CupertinoActivityIndicator(),
        )
            : (_pets.isEmpty || _pets == null
            ? Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: AltContent(randomNumber))
            : AnimatedListView(items: _pets)
        ),
      ),
    );
  }
}