import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/views/forgetPassword/controller.dart';
import 'package:pet_adoption/widgets/confirm_button.dart';
import 'package:pet_adoption/widgets/snack_bar.dart';
import 'package:pet_adoption/widgets/text_field.dart';

class ForgetPasswordView extends StatefulWidget {
  @override
  _ForgetPasswordViewState createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String _email;
  bool _isLoading = false;

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
              textInputType: TextInputType.emailAddress,
              onSaved: (String value)=> _email = value.trim(),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Invalid email';
                } else if (!value.contains('@') || !value.contains('.com')) {
                  return 'Email must be example@mail.com';
                }
              },
            ),
          ),
          Builder(
            builder: (ctx)=> _isLoading ? CupertinoActivityIndicator() : ConfirmButton(
              title: 'Reset password',
              onPressed: () async {
                _globalKey.currentState.save();
                if (_globalKey.currentState.validate()) {
                  FocusScope.of(context).unfocus();
                  setState(()=> _isLoading = true);
                  hideStatusBar();
                  String response = await ForgetPasswordController().resetPassword(_email);
                  showSnackBar(ctx, title: response, onPressed: (){},label: '');
                  setState(()=> _isLoading = false);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}