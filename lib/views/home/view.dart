import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/constants.dart';
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

  ScrollController _scrollController = ScrollController();
  List<List<dynamic>> tabBarView = [
    [1],
    [],
  ];

  @override
  void initState() {
    listenScroll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
              Expanded(
                flex: 3,
                child: tabBarView[tabIndex].isNotEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            tabIndex == 0
                                ? 'assets/images/cat.png'
                                : 'assets/images/dog.png',
                            height: sizeFromHeight(context, 3),
                          ),
                          Text(
                            tabIndex == 1
                                ? 'No friends to play with'
                                : 'I have kicked those stupid pets',
                            // ignore: deprecated_member_use
                            style: textTheme.subtitle,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'No pets available now',
                            // ignore: deprecated_member_use
                            style: textTheme.title,
                          ),
                        ],
                      )
                    : AnimatedListView(
                        controller: _scrollController,
                      ),
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