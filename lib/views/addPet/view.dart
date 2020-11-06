import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/core/models/pet.dart';
import 'package:pet_adoption/core/models/user.dart';
import 'package:pet_adoption/views/addPet/access_dialog.dart';
import 'package:pet_adoption/views/addPet/controller.dart';
import 'package:pet_adoption/views/home/squared_button.dart';
import 'package:pet_adoption/views/menu/menu_frame.dart';
import 'package:pet_adoption/views/profile/controller.dart';
import 'package:pet_adoption/widgets/snack_bar.dart';
import 'package:pet_adoption/widgets/text_field.dart';
import 'package:pet_adoption/widgets/confirm_button.dart';
import 'package:pet_adoption/widgets/default_app_bar.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

class AddPetView extends StatefulWidget {
  @override
  _AddPetViewState createState() => _AddPetViewState();
}

class _AddPetViewState extends State<AddPetView> {
  bool _isLoading = false;
  bool _isProcessing = false;
  int petIndex;
  String gender, petName, kind, description;
  int age;
  int descriptionLength = 0;
  File image;
  var processedUInt;
  UserSingleton _userSingleton = UserSingleton();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  AddPetController _addPetController = AddPetController();
  ScreenshotController _screenshotController = ScreenshotController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => showAccessDeniedDialog(context));
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final titleStyle = Theme.of(context).textTheme.subtitle;
    return Scaffold(
      appBar: defaultAppBar(context, title: 'Add Pet'),
      body: Form(
        key: _globalKey,
        child: Builder(
            builder: (ctx)=> ListView(
            padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
            children: [
              Text(
                'Pet Photo',
                style: titleStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 12,
              ),
              GestureDetector(
                  child: processedUInt != null
                      ? Screenshot(
                          controller: _screenshotController,
                          child: Container(
                              height: sizeFromHeight(context, 2),
                              color: Colors.transparent,
                              child: Image.memory(processedUInt)))
                      : Container(
                          height: sizeFromHeight(context, 4),
                          child: _isProcessing
                              ? CupertinoActivityIndicator(
                                  radius: 50,
                                )
                              : Container(
                                  height: 1,
                                ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(image == null
                                      ? logoLocation
                                      : image.path))),
                        ),
                  onTap: !_userSingleton.isPremium
                      ? () => showSnackBar(ctx,
                          title: 'Contact us to upgrade you to premium',
                          onPressed: () {},
                          label: '')
                      : () async {
                          image =
                              // ignore: deprecated_member_use
                              await ImagePicker.pickImage(
                                  source: ImageSource.gallery);
                          setState(() => _isProcessing = true);
                          processedUInt = await _addPetController.removeBG(image);
                          if (processedUInt == null) {
                            image = null;
                            showSnackBar(ctx,
                                title: 'Failed to load image',
                                onPressed: () async => await _report(),
                                label: 'Report');
                          } else
                            _screenshotController
                                .capture(
                                  delay: Duration(seconds: 1),
                                )
                                .then((value) => image = value);
                          setState(() => _isProcessing = false);
                        },
                ),
              Text(
                'Name',
                style: titleStyle,
              ),
              inputField(
                  textInputType: TextInputType.name,
                  hint: 'Pongo',
                  textInputAction: TextInputAction.next,
                  onSaved: (v) => petName = v,
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
                  hint: 'Bulldog',
                  textInputAction: TextInputAction.next,
                  onSaved: (v) => kind = v,
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
                  hint: '2 years old',
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  onSaved: (v) => age = int.parse(v),
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
                hint: 'Why you post this ?',
                onSaved: (v) => description = v,
                onChanged: (value) {
                  if (value.length <= 200)
                    setState(()=> descriptionLength = value.length);
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
                    onTap: ()=> setState(()=> petIndex = 0),
                  ),
                  Text(
                    'OR',
                    style: titleStyle,
                  ),
                  SquaredButton(
                    icon: FontAwesomeIcons.dog,
                    onTap: ()=> setState(()=> petIndex = 1),
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
                      onChanged: (value)=> setState(()=> gender = value)),
                  Text(
                    'Male',
                    style: titleStyle,
                  ),
                  Radio(
                      value: 'Female',
                      groupValue: gender,
                      onChanged: (value)=> setState(()=> gender = value)),
                  Text(
                    'Female',
                    style: titleStyle,
                  ),
                ],
              ),
              // premium condition
               _isLoading
                    ? Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : ConfirmButton(
                        onPressed: petIndex == null ||
                                gender == null ||
                                image == null ||
                                !_userSingleton.isPremium
                            ? null
                            : () async {
                                if (_globalKey.currentState.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  hideStatusBar();
                                  _globalKey.currentState.save();
                                  String _path = petIndex == 0 ? 'cats' : 'dogs';
                                  String photoUrl = await ProfileController()
                                      .uploadFile(
                                          path:
                                              '${_userSingleton.userId}/$petName',
                                          image: image);
                                  bool isMale = gender == 'Male' ? true : false;
                                  PetModel _petModel = PetModel(
                                    isCat: petIndex == 0,
                                    age: age,
                                    description: description,
                                    isMale: isMale,
                                    kind: kind,
                                    petName: petName,
                                    photoUrl: photoUrl,
                                    publishAt:
                                        DateTime.now().millisecondsSinceEpoch,
                                    userId: _userSingleton.userId,
                                  );
                                  String message = await _addPetController.addPet(
                                      _path, _petModel);
                                  showSnackBar(ctx,
                                      title: message,
                                      onPressed: () {},
                                      label: '');
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  if (message == 'Done') {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (_) => MenuFrame()));
                                  }
                                }
                              },
                      ),
              if (!_userSingleton.isPremium)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'You have no permission to add a pet contact the developer to give you access',
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _report() async {
    String appUrl =
        'mailto:gamilco81@gmail.com?subject=Pongo Report Feedback&body=Failed to load image';
    if (await canLaunch(appUrl)) {
      await launch(appUrl);
    }
  }
}