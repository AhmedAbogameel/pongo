import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:o_color_picker/o_color_picker.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/views/settings/inkwell.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String appUrl = 'https://play.google.com/store/apps/details?id=com.abogameel.pongo';
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final subtitleStyle = Theme.of(context).textTheme.subtitle;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBGColor,
        iconTheme: IconThemeData(color: kAccentColor),
        title: Text(
          'Settings',
          style: subtitleStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'App Theme',
                  style: subtitleStyle,
                ),
                TextButton(
                  child: Text('Reset Color'),
                  onPressed: () async {
                    SharedPreferences _prefs =
                        await SharedPreferences.getInstance();
                    _prefs.remove('accentColor');
                    setState(() {
                      kAccentColor = Color.fromRGBO(56, 97, 96, 1);
                    });
                  },
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 15),
              child: OColorPicker(
                  spacing: sizeFromWidth(context, 20),
                  boxBorder: OColorBoxBorder(color: kAccentColor, radius: 5),
                  selectedColor: kAccentColor,
                  onColorChange: (v) async {
                    setState(() {
                      kAccentColor = v;
                    });
                    SharedPreferences _prefs =
                        await SharedPreferences.getInstance();
                    _prefs.setInt('accentColor', v.value);
                  }),
            ),
            CustomInkWell(
                title: 'Share',
                icon: Icons.share_outlined,
                onTap: () => Share.share(appUrl)),
            CustomInkWell(
                title: 'Rate',
                icon: FontAwesomeIcons.star,
                onTap: () async => await _launchURL(appUrl),
            ),
            CustomInkWell(
                title: 'Feedback',
                icon: FontAwesomeIcons.commentAlt,
                onTap: () async => await _launchURL('mailto:gamilco81@gmail.com?subject=Pongo Feedback&body='''),
            ),
            CustomInkWell(
              title: 'About',
              icon: Icons.wysiwyg_rounded,
              onTap: () => showAboutDialog(
                context: context,
                applicationName: 'Pongo',
                applicationLegalese: 'Developed by Ahmed Abogameel',
                applicationVersion: '1.0.0',
                applicationIcon: Image.asset(
                  logoLocation,
                  height: 50,
                ),
              ),
            ),
            Opacity(
                opacity: 0.0,
                child: CustomInkWell(
                  title: '',
                  onTap: null,
                )),
          ],
        ),
      ),
    );
  }
  Future<void> _launchURL(appUrl) async {
    if (await canLaunch(appUrl)) {
      await launch(appUrl);
    }
  }
}
// share app, rate app, contact us
