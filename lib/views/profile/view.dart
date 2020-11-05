import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:pet_adoption/views/forgetPassword/view.dart';
import 'package:pet_adoption/views/login/controller.dart';
import 'package:pet_adoption/views/profile/controller.dart';
import 'package:pet_adoption/views/splash/view.dart';
import 'package:pet_adoption/widgets/snack_bar.dart';
import 'package:pet_adoption/widgets/text_field.dart';
import 'package:pet_adoption/widgets/confirm_button.dart';
import 'package:pet_adoption/widgets/default_app_bar.dart';
import '../../constants.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _isLoading = false;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  ProfileController _profileController = ProfileController();
  TextEditingController _nameController = TextEditingController();
  final UserSingleton _userModel = UserSingleton();

  String displayName = UserSingleton().displayName;
  String photoUrl = UserSingleton().photoUrl;
  String email = UserSingleton().email;
  String password;
  File image;
  @override
  void initState() {
    _nameController.text = displayName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final titleStyle = Theme.of(context).textTheme.subtitle;
    return Scaffold(
      appBar: defaultAppBar(context, title: 'Edit Profile'),
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
          children: [
            Text(
              'Change Photo',
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 12,
            ),
            GestureDetector(
              child: CircleAvatar(
                backgroundColor: kAccentColor.withOpacity(0.7),
                radius: sizeFromHeight(context, 5),
                backgroundImage: image == null ? NetworkImage(photoUrl) : AssetImage(image.path),
              ),
              onTap: ()async {
                image = await ImagePicker.pickImage(source: ImageSource.gallery);
                setState(() {});
              },
            ),
            Text(
              'Name',
              style: titleStyle,
            ),
            inputField(
              controller: _nameController,
              hint: _userModel.displayName,
              textInputType: TextInputType.name,
              onSaved: (v) => displayName = v,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Invalid Name';
                }
              },
            ),
            Text(
              'Password',
              style: titleStyle,
            ),
            inputField(
              hint: '********',
              textInputType: TextInputType.name,
              onSaved: (v) => password = v,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Invalid Password';
                }
              },
            ),
            Builder(
              builder: (ctx)=> _isLoading ? Center(
                child: CupertinoActivityIndicator(),
              ) : ConfirmButton(onPressed: () async {
                hideStatusBar();
                FocusScope.of(context).unfocus();
                if (_globalKey.currentState.validate()) {
                  setState(() {
                    _isLoading = true;
                  });
                  _globalKey.currentState.save();
                  final userModel =
                  await LoginController().login(email, password);
                  if (userModel.message != null) {
                    showSnackBar(ctx,
                        title: userModel.message,
                        onPressed: () {},
                        label: 'X');
                    setState(() {
                      _isLoading = false;
                    });
                    return;
                  }
                  photoUrl = await _profileController.uploadFile(image: image);
                  await _profileController.updateProfile(
                      displayName, photoUrl ?? '');
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => SplashView()));
                }
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text(
                    'Forgot password ? Reset now',
                    // ignore: deprecated_member_use
                    style: Theme.of(context).textTheme.body1,
                  ),
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ForgetPasswordView())),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}