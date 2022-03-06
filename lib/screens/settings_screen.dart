import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';

class SettingsScreen extends StatefulWidget{
  static const String idScreen = "settings";
  SettingsState createState()=> SettingsState();
}
class SettingsState extends State<SettingsScreen> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',
            style: GoogleFonts.raleway(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )
            )),
        backgroundColor: Colors.black,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            titlePadding: const EdgeInsets.all(20),
            title: 'Theme and Language',
            tiles: [
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                subtitleMaxLines: 4,
                leading: const Icon(Icons.language),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: 'Use System Theme',
                leading: const Icon(Icons.phone_android),
                switchValue: isSwitched,
                onToggle: (value) {
                  setState(({ switchValue: true}) {
                    isSwitched = value;
                    EasyDynamicTheme.of(context).changeTheme(dynamic: value);
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            titlePadding: const EdgeInsets.all(20),
            title: 'Section 2',
            tiles: [
              SettingsTile(
                title: 'Security',
                subtitle: 'Fingerprint',
                leading: const Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: 'Use fingerprint',
                leading: const Icon(Icons.fingerprint),
                switchValue: true,
                onToggle: (value) {
                  setState(() {
                    isSwitched = true;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}