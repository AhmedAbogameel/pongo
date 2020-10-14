import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/views/home/pet_tile.dart';
import 'package:pet_adoption/views/home/squared_button.dart';
import 'package:pet_adoption/views/home/text_field.dart';
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              height: sizeFromHeight(context, 1),
              child: Column(
                children: [
                  inputField((String value) {
                    SystemChrome.setEnabledSystemUIOverlays([]);
                  }),
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
                    child: AnimationLimiter(
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (_, listIndex) =>
                            AnimationConfiguration.staggeredList(
                          position: listIndex,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: PetCard(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}