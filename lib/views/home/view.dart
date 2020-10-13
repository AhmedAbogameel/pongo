import 'package:flutter/material.dart';
import 'package:pet_adoption/constants.dart';
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
          padding: EdgeInsets.all(25),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              height: sizeFromHeight(context, 1),
              child: Column(
                children: [
                  inputField((String value) {}),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (_, listIndex) => SquaredButton(
                        tabIndex: tabIndex,
                        listIndex: listIndex,
                        onTap: () {
                          setState(() {
                            tabIndex = listIndex;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    flex: 3,
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (_, listIndex) =>
                          Icon(tabIndex == 0 ? Icons.add : Icons.remove),
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
