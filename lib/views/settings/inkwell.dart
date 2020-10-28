import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomInkWell extends StatelessWidget {
  final String title;
  final Function onTap;
  final IconData icon;
  CustomInkWell({@required this.title, @required this.onTap,@required this.icon});
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final subtitleStyle = Theme.of(context).textTheme.subtitle;
    return InkWell(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      splashColor: kAccentColor,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon,size: 17,color: kAccentColor,),
              SizedBox(width: 10,),
              Text(
                title,
                style: subtitleStyle,
              ),
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}