import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/views/home/squared_button.dart';
import 'package:pet_adoption/views/home/text_field.dart';

class AddPetView extends StatefulWidget {
  @override
  _AddPetViewState createState() => _AddPetViewState();
}

class _AddPetViewState extends State<AddPetView> {
  int petIndex;
  String gender;
  int descriptionLength = 0;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final titleStyle = Theme.of(context).textTheme.subtitle;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 25),
          children: [
            GestureDetector(
              child: CircleAvatar(
                backgroundColor: kAccentColor.withOpacity(0.7),
                radius: sizeFromHeight(context, 8),
                child: Text('Upload pet image'),
              ),
              onDoubleTap: () {},
            ),
            Text(
              'Name',
              style: titleStyle,
            ),
            inputField(
                textInputType: TextInputType.name,
                onSaved: (v) {},
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your pet Name';
                  }
                }),
            Text(
              'Kind',
              style: titleStyle,
            ),
            inputField(
                textInputType: TextInputType.name,
                onSaved: (v) {},
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your pet kind';
                  }
                }),
            Text(
              'Age',
              style: titleStyle,
            ),
            inputField(
                textInputType: TextInputType.number,
                onSaved: (v) {},
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your pet age';
                  } else if (value.contains('.') ||
                      value.contains(',') ||
                      value.contains('-')) {
                    return 'Age should be positive integer number';
                  }
                }),
            Text(
              'Description',
              style: titleStyle,
            ),
            inputField(
              textInputType: TextInputType.name,
              onSaved: (v) {},
              onChanged: (value) {
                if (value.length <= 200)
                  setState(() {
                    descriptionLength = value.length;
                  });
              },
              counter: descriptionLength,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a Description';
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SquaredButton(
                  petIndex: 0,
                  tabIndex: petIndex,
                  icon: FontAwesomeIcons.cat,
                  onTap: () {
                    setState(() {
                      petIndex = 0;
                    });
                  },
                ),
                Text(
                  'OR',
                  style: titleStyle,
                ),
                SquaredButton(
                  icon: FontAwesomeIcons.dog,
                  onTap: () {
                    setState(() {
                      petIndex = 1;
                    });
                  },
                  tabIndex: petIndex,
                  petIndex: 1,
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio(
                    value: 'Male',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    }),
                Text(
                  'Male',
                  style: titleStyle,
                ),
                Radio(
                    value: 'Female',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    }),
                Text(
                  'Female',
                  style: titleStyle,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              height: 50,
              child: RaisedButton(
                child: Text('Add'),
                color: kAccentColor,
                colorBrightness: Brightness.dark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: petIndex == null || gender == null
                    ? null
                    : () {
                        if (_globalKey.currentState.validate()) {
                          SystemChrome.setEnabledSystemUIOverlays([]);
                          _globalKey.currentState.save();
                          // petIndex , gender
                        }
                      },
              ),
            )
          ],
        ),
      ),
    );
  }
}
