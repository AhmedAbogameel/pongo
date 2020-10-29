import 'package:flutter/material.dart';
import 'package:pet_adoption/core/models/user.dart';
import '../constants.dart';

class ProfileAvatar extends StatelessWidget {
  final UserSingleton _userModel = UserSingleton();
  final String photoUrl;
  ProfileAvatar(this.photoUrl);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: kPrimaryColor,
        backgroundImage: photoUrl != null
            ? NetworkImage(photoUrl)
            : _userModel.photoUrl == null || _userModel.photoUrl == ''
                ? AssetImage(logoLocation)
                : NetworkImage(_userModel.photoUrl),
      ),
    );
  }
}