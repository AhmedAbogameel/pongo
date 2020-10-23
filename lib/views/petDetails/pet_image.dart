import 'package:flutter/material.dart';
import '../../constants.dart';

class PetImage extends StatelessWidget {
  final String photoUrl;
  PetImage(this.photoUrl);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(context, 2, removeAppBarSize: false),
      color: kPrimaryColor,
      child: Hero(
        tag: photoUrl,
        child: Image.network(photoUrl),
      ),
      alignment: Alignment.center,
    );
  }
}
