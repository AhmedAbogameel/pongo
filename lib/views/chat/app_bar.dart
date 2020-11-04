import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:pet_adoption/core/models/user_model.dart';
import 'package:pet_adoption/widgets/profile_avatar.dart';
import 'package:pet_adoption/widgets/snack_bar.dart';
import '../../constants.dart';

Widget chatAppBar(BuildContext context,UserModel user, {Function afterCopy}){
  final textTheme = Theme.of(context).textTheme;
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 40,
          padding: EdgeInsets.all(1),
          child: Hero(
            tag: user.photoUrl,
            child: ProfileAvatar(
                user.photoUrl,
            ),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kAccentColor,
          ),
        ),
        Text(
          user.displayName,
          // ignore: deprecated_member_use
          style: textTheme.body1,
        ),
        Spacer(),
      ],
    ),
    leading: IconButton(icon: Icon(Icons.arrow_back_ios_outlined), onPressed: ()async{
      await Future.delayed(Duration.zero,()=> FocusScope.of(context).unfocus());
      Navigator.pop(context);
    }),
    actions: [
      Builder(
        builder: (ctx)=> IconButton(
          // or mapMarkerAlt
          icon: Icon(FontAwesomeIcons.mapMarkedAlt),
          onPressed: () async {
            LocationResult result = await showLocationPicker(
              context, 'AIzaSyCtYNAbeu3NY7yVVn9-gM4cd1x1UbHk2Ck',
              // initialCenter: LatLng(31.1975844, 29.9598339),
              myLocationButtonEnabled: true,
              layersButtonEnabled: true,
              desiredAccuracy: LocationAccuracy.best,
              requiredGPS: true,
              resultCardConfirmIcon: Icon(Icons.copy),
            );
            FlutterClipboard.copy(result.latLng.toString());
            showSnackBar(ctx, title: 'Location copied!', onPressed: afterCopy,label: 'Paste');
          },
        ),
      ),
    ],
    backgroundColor: kBGColor,
    iconTheme: IconThemeData(color: kAccentColor),
  );
}