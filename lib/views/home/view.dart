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

  List<List<dynamic>> tabBarView = [
    [1],
    [],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(() {
        setState(() {
          widget.menuCallBack();
        });
      }),
      body: AbsorbPointer(
        absorbing: widget.menuOpen,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
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
                Row(
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
                Expanded(
                  flex: 3,
                  child: tabBarView[tabIndex].isNotEmpty ? Center(child: Text('Nothing To Show')) : AnimatedListView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}