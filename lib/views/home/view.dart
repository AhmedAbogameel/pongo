import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/core/models/pet.dart';
import 'package:pet_adoption/views/home/alt_content.dart';
import 'package:pet_adoption/views/home/controller.dart';
import 'package:pet_adoption/views/home/squared_button.dart';
import 'package:pet_adoption/views/search/controller.dart';
import 'package:pet_adoption/views/search/view.dart';
import 'package:pet_adoption/widgets/text_field.dart';
import 'package:pet_adoption/widgets/animated_list_view.dart';
import 'package:pet_adoption/widgets/app_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
  bool _absorbingPanel = true;
  List<PetModel> _cats, _dogs;
  HomeController _homeController = HomeController();
  PanelController _panelController = PanelController();

  @override
  void initState() {
    _getPets();
    super.initState();
  }

  Future<void> _getPets() async {
    _cats = await _homeController.getPets('pets/cats');
    _dogs = await _homeController.getPets('pets/dogs');
    SearchController().allPets = _cats + _dogs;
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
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_)=> SearchView())),
                    icon: FontAwesomeIcons.search,
                  ),
                ),
                Expanded(
                  child: _isLoading
                      ? CupertinoActivityIndicator()
                      : tabBarView[tabIndex],
                ),
                SlidingUpPanel(
                  controller: _panelController,
                  minHeight: sizeFromHeight(context, 20),
                  maxHeight: sizeFromHeight(context,4.7),
                  onPanelOpened: ()=>
                    setState(()=> _absorbingPanel = false),
                  onPanelClosed: ()=>
                    setState(()=>_absorbingPanel = true),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  panel: GestureDetector(
                    onTap: _absorbingPanel ? ()=> _panelController.open() : null,
                    child: AbsorbPointer(
                      absorbing: _absorbingPanel,
                      child: Stack(
                        children: [
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
                          ),
                          Positioned(
                            top: 5,
                            right: 0,
                            left: 0,
                            child: AnimatedOpacity(
                              duration: Duration(milliseconds: 500),
                              opacity: _absorbingPanel ? 0.7 : 0,
                              curve: Curves.fastOutSlowIn,
                              child: Icon(
                                FontAwesomeIcons.chevronUp,
                                color: kBGColor,
                                size: 35,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 0,
                            left: 0,
                            child: AnimatedOpacity(
                              curve: Curves.fastOutSlowIn,
                              duration: Duration(milliseconds: 500),
                              opacity: !_absorbingPanel ? 0.7 : 0,
                              child: GestureDetector(
                                child: Icon(
                                  FontAwesomeIcons.chevronDown,
                                  color: kBGColor,
                                  size: 35,
                                ),
                                  onTap: ()=> _panelController.close()
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}