import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wedding_planner/main.dart';
import 'package:wedding_planner/themes.dart';

import 'app_bar.dart';
import 'bottom_nav_bar.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WPAppBar(
        title: 'Settings',
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColours.primary, Color.fromRGBO(255, 255, 255, 1)],
          ),
        ),
        child: Drawer(
          semanticLabel: 'Settings',
          child: SettingsList(
            sections: [
              SettingsSection(
                title: Text('Common'),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    leading: Icon(Icons.language),
                    title: Text('Language'),
                    value: Text('English'),
                  ),
                  SettingsTile.switchTile(
                    onToggle: (value) {},
                    initialValue: true,
                    leading: Icon(Icons.format_paint),
                    title: Text('Enable custom theme'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 4),
    );
  }
}