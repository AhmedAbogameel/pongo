import 'package:flutter/material.dart';
import 'package:pet_adoption/core/models/user.dart';
import '../constants.dart';

class ProfileAvatar extends StatelessWidget {
  final UserModel _userModel = UserModel();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: kPrimaryColor,
        // backgroundImage: AssetImage(),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: _userModel.photoUrl == null ? Image.asset(logoLocation) : Image.network(_userModel.photoUrl),
        ),
      ),
    );
  }
}
