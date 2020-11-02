import 'package:flutter/material.dart';
import '../../constants.dart';

class SquaredButton extends StatelessWidget {
  final int petIndex,tabIndex;
  final Function onTap;
  final IconData icon;
  SquaredButton({this.tabIndex,this.icon,this.petIndex,this.onTap});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Container(
            width: sizeFromWidth(context, 3.5),
            height: sizeFromHeight(context, 8),
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Icon(icon,color: tabIndex == petIndex ? kBGColor : kPrimaryColor,size: 50,),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: tabIndex == petIndex
                  ? kAccentColor
                  : Colors.white,
                blurRadius: 3,
              ),],
                color: tabIndex == petIndex
                    ? kPrimaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(25),),
          ),
          onTap: onTap,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Text(
            petIndex == 0 ? 'Cats' : 'Dogs',
            style: TextStyle(fontSize: 15,color: kPrimaryColor,fontWeight: FontWeight.w900),
          ),
        ),
      ],
    );
  }
}