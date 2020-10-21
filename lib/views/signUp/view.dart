import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/widgets/text_field.dart';
import 'package:pet_adoption/widgets/confirm_button.dart';
import 'package:pet_adoption/widgets/default_app_bar.dart';
import '../../constants.dart';

class SignUpView extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: defaultAppBar(context, title: 'SignUp'),
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(25,25,25,0),
          children: [
            Image.asset(logoLocation,
                height: sizeFromHeight(
                  context,
                  4,
                  removeAppBarSize: false,
                ),
            ),
            // ignore: deprecated_member_use
            SizedBox(
              height: sizeFromHeight(context, 20),
            ),
            Text(
              'Name',
              // ignore: deprecated_member_use
              style: theme.subtitle,
            ),
            inputField(
              hint: 'Jemi',
              icon: Icons.person,
              textInputType: TextInputType.name,
              onSaved: (String value) {},
              textInputAction: TextInputAction.next,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Invalid name';
                }
              },
            ),
            Text(
              'Email',
              // ignore: deprecated_member_use
              style: theme.subtitle,
            ),
            inputField(
              hint: 'example@mail.com',
              icon: Icons.email,
              textInputType: TextInputType.emailAddress,
              onSaved: (String value) {},
              textInputAction: TextInputAction.next,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Invalid email';
                }else if(!value.contains('@') || !value.contains('.com')){
                  return 'Email must be example@mail.com';
                }
              },
            ),
            Text(
              'Password',
              // ignore: deprecated_member_use
              style: theme.subtitle,
            ),
            inputField(
              hint: '*******',
              icon: FontAwesomeIcons.key,
              textInputType: TextInputType.text,
              onSaved: (String value) {},
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Invalid password';
                }else if(value.length < 8){
                  return 'Password must be 8 or more in length';
                }
              },
            ),
            ConfirmButton(onPressed: () {
              if (_globalKey.currentState.validate()) {
                SystemChrome.setEnabledSystemUIOverlays([]);
                _globalKey.currentState.save();
                hideStatusBar();
              }
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text(
                    'Do You Have email ? Login now',
                    // ignore: deprecated_member_use
                    style: theme.body1,
                  ),
                  onPressed: () {
                    //_rotationController.reset();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => SignUpView()));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}