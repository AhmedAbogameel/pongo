import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:pet_adoption/views/addPet/view.dart';
import 'package:pet_adoption/views/adoption/view.dart';
import 'package:pet_adoption/views/favourite/view.dart';
import 'package:pet_adoption/views/login/view.dart';
import 'package:pet_adoption/views/profile/view.dart';
import 'package:pet_adoption/views/test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuView extends StatefulWidget {
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  List<String> menuItems = [
    'Adoption',
    'Donation \n(Coming Soon)',
    'Add pet',
    'Favorites',
    'Messages',
    'Profile',
  ];

  List<IconData> icons = [
    FontAwesomeIcons.paw,
    FontAwesomeIcons.home,
    FontAwesomeIcons.plus,
    FontAwesomeIcons.heart,
    FontAwesomeIcons.envelope,
    FontAwesomeIcons.userAlt,
  ];

  List<Widget> menuNavigator = [
    AdoptionView(),
    Container(),
    AddPetView(),
    FavouriteView(),
    TestView(),
    ProfileView(),
  ];

  Widget buildMenuRow(int index) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: index == 1
          ? null
          : () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => menuNavigator[index]));
            },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0),
        child: Row(
          children: <Widget>[
            Icon(
              icons[index],
              color: Colors.white.withOpacity(0.5),
            ),
            SizedBox(
              width: 16.0,
            ),
            Text(
              menuItems[index],
              style: style,
            ),
          ],
        ),
      ),
    );
  }

  final style = TextStyle(
    color: Colors.white.withOpacity(0.5),
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
  );

  UserModel _userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kAccentColor,
      child: Container(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 24.0,
                      backgroundImage: _userModel.photoUrl == null  || _userModel.photoUrl == ''
                          ? AssetImage(logoLocation)
                          : NetworkImage(_userModel.photoUrl),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _userModel.displayName,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 22.0,
                          ),
                        ),
                        Text(
                          _userModel.email,
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: menuItems
                      .asMap()
                      .entries
                      .map((mapEntry) => buildMenuRow(mapEntry.key))
                      .toList(),
                ),
                Row(
                  children: <Widget>[
                    TextButton(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.cog,
                            color: Colors.white.withOpacity(0.5),
                            size: 20,
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Text(
                            'Settings',
                            style: style,
                          ),
                        ],
                      ),
                      onPressed: () {
                        print('navigate to setting');
                      },
                    ),
                    Text(
                      '   |   ',
                      style: style,
                    ),
                    TextButton(
                      child: Text(
                        'Log out',
                        style: style,
                      ),
                      onPressed: () async {
                        SharedPreferences _prefs =
                            await SharedPreferences.getInstance();
                        await _prefs.clear();
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => LoginView()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
