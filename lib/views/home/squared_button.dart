import 'package:flutter/material.dart';
import '../../constants.dart';

class SquaredButton extends StatelessWidget {
  final int listIndex,tabIndex;
  final Function onTap;
  final IconData icon;
  SquaredButton({this.tabIndex,this.icon,this.listIndex,this.onTap});
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
            child: Icon(icon,color: tabIndex == listIndex ? kBGColor : kPrimaryColor,size: 50,),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: tabIndex == listIndex
                  ? kAccentColor
                  : Colors.white,
                blurRadius: 3,
              ),],
                color: tabIndex == listIndex
                    ? kPrimaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(25),),
          ),
          onTap: onTap,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Text(
            listIndex == 0 ? 'Cats' : 'Dogs',
            style: TextStyle(fontSize: 20,color: kPrimaryColor,fontWeight: FontWeight.w900),
          ),
        ),
      ],
    );
  }
}
