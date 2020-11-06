import 'package:flutter/material.dart';
import '../constants.dart';

class ProfileAvatar extends StatelessWidget {
  final String photoUrl;
  ProfileAvatar(this.photoUrl);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: kPrimaryColor,
        backgroundImage: NetworkImage(photoUrl),
      ),
    );
  }
}