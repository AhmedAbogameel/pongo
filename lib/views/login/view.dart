import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/views/forgetPassword/view.dart';
import 'package:pet_adoption/views/login/controller.dart';
import 'package:pet_adoption/views/signUp/view.dart';
import 'package:pet_adoption/widgets/snack_bar.dart';
import 'package:pet_adoption/widgets/text_field.dart';
import 'package:pet_adoption/views/menu/menu_frame.dart';
import 'package:pet_adoption/widgets/confirm_button.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  String email,password;

  AnimationController _rotationController;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  LoginController _loginController = LoginController();
  @override
  void initState() {
    _rotationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _rotationController.dispose();
  }
  double _logoHeight = 3;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 2),
              curve: Curves.ease,
              height: sizeFromHeight(context, _logoHeight, removeAppBarSize: false),
              child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_rotationController),
                child: Image.asset(
                  logoLocation,
                ),
              ),
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
                onSaved: (String value)=> email = value,
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
                hint: '********',
                icon: FontAwesomeIcons.key,
                onSaved: (String value)=> password = value,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Invalid password';
                  } else if (value.length < 8) {
                    return 'Password must be 8 or more in length';
                  }
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  // ignore: deprecated_member_use
                  child: Text(
                    'Forgot Password?',
                    // ignore: deprecated_member_use
                    style: theme.body1,
                  ),
                  onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (_)=> ForgetPasswordView())),
                ),
              ],
            ),
            Builder(
              builder: (ctx)=> ConfirmButton(
                title: 'Login',
                onPressed: ()async {
                  if (_globalKey.currentState.validate()) {
                    _loading();
                    _globalKey.currentState.save();
                    FocusScope.of(context).unfocus();
                    final userModel = await _loginController.login(email, password);
                    if(userModel.message != null){
                      _stopLoading();
                      showSnackBar(ctx, title: userModel.message, onPressed: (){},label: 'X');
                    }else{
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> MenuFrame()));
                    }
                    hideStatusBar();
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text(
                    'Don\'t have an email ? Sign up now',
                    // ignore: deprecated_member_use
                    style: theme.body1,
                  ),
                  onPressed: ()=> Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => SignUpView())),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void _loading(){
    setState(() {
      _logoHeight = 1;
    });
    _rotationController.repeat();
  }
  void _stopLoading(){
    setState(() {
      _logoHeight = 3;
    });
    _rotationController.reset();
  }
}