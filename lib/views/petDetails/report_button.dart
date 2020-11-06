import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/core/models/pet.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';

class ReportButton extends StatelessWidget {
  final PetModel petModel;
  ReportButton(this.petModel);
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 18,
        right: 7,
        child: IconButton(
          icon: Icon(
            FontAwesomeIcons.bug,
            color: kAccentColor,
            size: 30,
          ),
          onPressed: () async {
            String appUrl =
                'mailto:gamilco81@gmail.com?subject=Pongo Report a BUG&body=OwnerPetId : ${petModel.userId}\nPetName : ${petModel.petName}\nPetPhoto : ${petModel.photoUrl}';
            if (await canLaunch(appUrl)) {
              await launch(appUrl);
            }
          },
        ));
  }
}