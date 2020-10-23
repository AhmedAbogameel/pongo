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
  ScrollController _scrollController = ScrollController();
  HomeController _homeController = HomeController();

  @override
  void initState() {
    _getPets();
    listenScroll();
    super.initState();
  }

  void _getPets() async {
    _cats = await _homeController.getPets('cats');
    _dogs = await _homeController.getPets('dogs');
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
        controller: _scrollController,
      ),
      _dogs == null || _dogs.isEmpty
          ? AltContent(tabIndex)
          : AnimatedListView(
        controller: _scrollController,
        items: _dogs,
      ),
    ];

    return Scaffold(
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
                  icon: FontAwesomeIcons.search,
                  onSubmit: (String value) {
                    hideStatusBar();
                  },
                ),
              ),
              if (!hideSections)
                AnimatedOpacity(
                  duration: Duration(milliseconds: 750),
                  opacity: opacity,
                  curve: Curves.ease,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              _isLoading
                  ? Expanded(
                      child: CupertinoActivityIndicator(),
                    )
                  : Expanded(
                      flex: 3,
                      child: tabBarView[tabIndex],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  bool hideSections = false;
  double opacity = 1;

  void listenScroll() {
    double lastOffset = 0;
    _scrollController.addListener(() {
      if (_scrollController.offset <= lastOffset ||
          _scrollController.offset < 0) {
        setState(() {
          opacity = 1;
          hideSections = false;
        });
        if (_scrollController.offset > 0) lastOffset = _scrollController.offset;
      } else {
        setState(() {
          opacity = 0;
          Timer(Duration(milliseconds: 750), () {
            hideSections = true;
          });
        });
        lastOffset = _scrollController.offset;
      }
    });
  }
}
