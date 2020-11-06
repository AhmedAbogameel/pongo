import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/views/login/view.dart';
import 'package:pet_adoption/views/menu/menu_frame.dart';
import 'package:pet_adoption/views/signUp/controller.dart';
import 'package:pet_adoption/widgets/snack_bar.dart';
import 'package:pet_adoption/widgets/text_field.dart';
import 'package:pet_adoption/widgets/confirm_button.dart';
import 'package:pet_adoption/widgets/default_app_bar.dart';
import '../../constants.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> with TickerProviderStateMixin {
  double _logoHeight = 4;
  String email,displayName,password;

  AnimationController _rotationController;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  SignUpController _signUpController = SignUpController();

  @override
  void initState() {
    _rotationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: defaultAppBar(context, title: 'SignUp'),
      body: Form(
        key: _globalKey,
        child: AbsorbPointer(
          absorbing: _rotationController.isAnimating,
          child: ListView(
            padding: EdgeInsets.fromLTRB(25,25,25,0),
            cacheExtent: sizeFromHeight(context, 1),
            children: [
              AnimatedContainer(
                duration: Duration(seconds: 5),
                curve: Curves.ease,
                height: sizeFromHeight(context, _logoHeight, removeAppBarSize: false),
                child: RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(_rotationController),
                  child: Image.asset(
                    logoLocation,
                  ),
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
                onSaved: (String value)=> displayName = value.trim(),
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
                hint: '*******',
                icon: FontAwesomeIcons.key,
                textInputType: TextInputType.text,
                onSaved: (String value)=> password = value,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Invalid password';
                  }else if(value.length < 8){
                    return 'Password must be 8 or more in length';
                  }
                },
              ),
              Builder(
                builder: (ctx)=> ConfirmButton(
                  onPressed: () async{
                    if (_globalKey.currentState.validate()) {
                      _loading();
                      _globalKey.currentState.save();
                      FocusScope.of(context).unfocus();
                      final userModel = await _signUpController.signUp(email, password, displayName);
                      if(userModel.message != null){
                        _stopLoading();
                        showSnackBar(ctx, title: userModel.message, onPressed: (){},label: 'X');
                      }else{
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> MenuFrame()));
                      }
                      hideStatusBar();
                    }
                  },),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text(
                      'Do You Have email ? Login now',
                      // ignore: deprecated_member_use
                      style: theme.body1,
                    ),
                    onPressed: ()=> Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => LoginView())),
                  ),
                ],
              )
            ],
          ),
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
      _logoHeight = 4;
    });
    _rotationController.reset();
  }
}