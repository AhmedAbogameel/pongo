import 'package:flutter/material.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/widgets/confirm_button.dart';
import 'package:pet_adoption/widgets/text_field.dart';

class ForgetPasswordView extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      // ignore: deprecated_member_use
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Reset Password',
          // ignore: deprecated_member_use
          style: theme.subtitle,
        ),
        iconTheme: IconThemeData(color: kAccentColor),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
        children: [
          Image.asset(logoLocation,
              height: sizeFromHeight(
                context,
                3,
                removeAppBarSize: false,
              )),
          // ignore: deprecated_member_use
          SizedBox(
            height: sizeFromHeight(context, 20),
          ),
          Text(
            'Email',
            // ignore: deprecated_member_use
            style: theme.subtitle,
          ),
          Form(
            key: _globalKey,
            child: inputField(
              hint: 'example@mail.com',
              icon: Icons.email,
              textInputType: TextInputType.number,
              onSaved: (String value) {},
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Invalid email';
                } else if (!value.contains('@') || !value.contains('.com')) {
                  return 'Email must be example@mail.com';
                }
              },
            ),
          ),
          ConfirmButton(
            title: 'Reset password',
            onPressed: () {
              _globalKey.currentState.save();
              if (_globalKey.currentState.validate()) {
                Navigator.pop(context);
                hideStatusBar();
              }
            },
          ),
        ],
      ),
    );
  }
}