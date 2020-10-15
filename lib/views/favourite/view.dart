import 'package:flutter/material.dart';
import 'package:pet_adoption/widgets/animated_list_view.dart';
import 'package:pet_adoption/widgets/default_app_bar.dart';

class FavouriteView extends StatefulWidget {
  @override
  _FavouriteViewState createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context,title: 'My Favourite List'),
      body: AnimatedListView(),
    );
  }
}
