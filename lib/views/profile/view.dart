import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_adoption/views/forgetPassword/view.dart';
import 'package:pet_adoption/widgets/text_field.dart';
import 'package:pet_adoption/widgets/confirm_button.dart';
import 'package:pet_adoption/widgets/default_app_bar.dart';
import '../../constants.dart';

class ProfileView extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final titleStyle = Theme.of(context).textTheme.subtitle;
    return Scaffold(
      appBar: defaultAppBar(context, title: 'Edit Profile'),
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(25,25,25,0),
          children: [
            GestureDetector(
              child: CircleAvatar(
                backgroundColor: kAccentColor.withOpacity(0.7),
                radius: sizeFromHeight(context, 8),
                child: Text('Upload pet image'),
              ),
              onTap: () {},
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
                  return 'Invalid Name';
                }
              },
            ),
            Text(
              'Email',
              style: titleStyle,
            ),
            inputField(
              textInputType: TextInputType.name,
              onSaved: (v) {},
              validator: (value) {
                if (value.isEmpty) {
                  return 'Invalid Email';
                }
              },
            ),
            Text(
              'Password',
              style: titleStyle,
            ),
            inputField(
              textInputType: TextInputType.name,
              onSaved: (v) {},
              validator: (value) {
                if (value.isEmpty) {
                  return 'Invalid Password';
                }
              },
            ),
            ConfirmButton(onPressed: () {
              if (_globalKey.currentState.validate()) {
                SystemChrome.setEnabledSystemUIOverlays([]);
                _globalKey.currentState.save();

              }
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text(
                    'Forgot password ? Reset now',
                    // ignore: deprecated_member_use
                    style: Theme.of(context).textTheme.body1,
                  ),
                  onPressed: () {
                    //_rotationController.reset();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ForgetPasswordView()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}