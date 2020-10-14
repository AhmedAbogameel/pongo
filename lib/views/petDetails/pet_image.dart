import 'package:flutter/material.dart';
import '../../constants.dart';

class PetImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(context, 2, removeAppBarSize: false),
      color: kPrimaryColor,
      child: Hero(
        tag: '1',
        child: Image.network(
          'https://e7.pngegg.com/pngimages/665/236/png-clipart-cute-dog-puppy-dog.png',
        ),
      ),
      alignment: Alignment.center,
    );
  }
}
