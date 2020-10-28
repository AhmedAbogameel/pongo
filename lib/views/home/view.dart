import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/core/models/pet.dart';
import 'package:pet_adoption/views/home/alt_content.dart';
import 'package:pet_adoption/views/home/controller.dart';
import 'package:pet_adoption/views/home/squared_button.dart';
import 'package:pet_adoption/widgets/text_field.dart';
import 'package:pet_adoption/widgets/animated_list_view.dart';
import 'package:pet_adoption/widgets/app_bar.dart';

class HomeView extends StatefulWidget {
  final Function menuCallBack;
  final bool menuOpen;
  HomeView({@required this.menuCallBack, @required this.menuOpen});
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int tabIndex = 0;
  bool _isLoading = true;
  List<PetModel> _cats, _dogs;
  HomeController _homeController = HomeController();

  @override
  void initState() {
    _getPets();
    super.initState();
  }

  Future<void> _getPets() async {
    _cats = await _homeController.getPets('pets/cats');
    _dogs = await _homeController.getPets('pets/dogs');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabBarView = [
      _cats == null || _cats.isEmpty
          ? AltContent(tabIndex)
          : AnimatedListView(
              items: _cats,
            ),
      _dogs == null || _dogs.isEmpty
          ? AltContent(tabIndex)
          : AnimatedListView(
              items: _dogs,
            ),
    ];

    return RefreshIndicator(
      onRefresh: _getPets,
      child: Scaffold(
        appBar: appBar(() {
          setState(() {
            widget.menuCallBack();
          });
        }),
        body: AbsorbPointer(
          absorbing: widget.menuOpen,
          child: Container(
            height: sizeFromHeight(context, 1),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: inputField(
                    hint: 'Search',
                    readOnly: true,
                    onTap: () => print('Navigate to search view'),
                    icon: FontAwesomeIcons.search,
                  ),
                ),
                Expanded(
                  child: _isLoading
                      ? CupertinoActivityIndicator()
                      : tabBarView[tabIndex],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: kAccentColor.withOpacity(0.7),
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SquaredButton(
                        petIndex: 0,
                        tabIndex: tabIndex,
                        icon: FontAwesomeIcons.cat,
                        onTap: () {
                          setState(() {
                            tabIndex = 0;
                          });
                        },
                      ),
                      SquaredButton(
                        icon: FontAwesomeIcons.dog,
                        onTap: () {
                          setState(() {
                            tabIndex = 1;
                          });
                        },
                        tabIndex: tabIndex,
                        petIndex: 1,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}