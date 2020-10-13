import 'package:flutter/material.dart';

import '../../constants.dart';

class SquaredButton extends StatelessWidget {
  final int listIndex,tabIndex;
  final Function onTap;
  SquaredButton({this.tabIndex,this.listIndex,this.onTap});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Container(
            width: sizeFromWidth(context, 3.5),
            height: sizeFromHeight(context, 8),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: tabIndex == listIndex
                    ? kPrimaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(25)),
          ),
          onTap: onTap,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Text(
            listIndex == 0 ? 'Cats' : 'Dogs',
            style: TextStyle(fontSize: 20,color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
