import 'package:flutter/material.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/views/home/view.dart';
import 'package:pet_adoption/views/menu/view.dart';

class MenuFrame extends StatefulWidget {
  @override
  _MenuFrameState createState() => _MenuFrameState();
}

class _MenuFrameState extends State<MenuFrame>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scaleTransition;
  Duration _duration = Duration(milliseconds: 300);
  bool menuIsOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
    );
    _scaleTransition = Tween<double>(begin: 1.0,end: 0.6).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MenuView(),
        AnimatedPositioned(
          top: menuIsOpen ? 75 : 0,
          bottom: menuIsOpen ? 75 : 0,
          right: menuIsOpen ? -sizeFromWidth(context, 2) : 0,
          left:  menuIsOpen ? sizeFromWidth(context, 2) : 0,
          child: ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(menuIsOpen ? 30 : 0 )),
              child: ScaleTransition(scale: _scaleTransition,child: GestureDetector(
                child: HomeView(menuCallBack: (){
                  setState(() {
                    menuIsOpen = !menuIsOpen;
                  });
                },menuOpen: menuIsOpen,),
                onTap: (){
                  if(menuIsOpen)
                    setState(() {
                      menuIsOpen = false;
                    });
                },
              ),),),
          duration: _duration,
        ),
      ],
    );
  }
}
