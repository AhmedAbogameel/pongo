import 'package:flutter/material.dart';

import '../../constants.dart';

class CircledButton extends StatelessWidget {
  final bool isAdd;
  final Function onTap;

  CircledButton({@required this.isAdd,@required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: kAccentColor,
      hoverColor: kAccentColor,
      borderRadius: BorderRadius.circular(50),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          child: Icon(isAdd ? Icons.add : Icons.remove,color: kAccentColor,),
          backgroundColor: kPrimaryColor,
        ),
      ),
      onTap: onTap,
    );
  }
}
