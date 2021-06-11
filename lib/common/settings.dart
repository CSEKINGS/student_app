import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:student_app/theme/theme.dart';
import 'package:student_app/theme/theme_notifier.dart';
import 'package:student_app/theme/theme_shared_pref.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _darkTheme = true;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.brush_outlined),
            title: const Text('Theme'),
            contentPadding: const EdgeInsets.all(16.0),
            trailing: DayNightSwitcher(
              isDarkModeEnabled: _darkTheme,
              onStateChanged: (val) {
                setState(() {
                  _darkTheme = val;
                });
                onThemeChanged(val, themeNotifier);
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: Theme.of(context).backgroundColor,
                  title: const Text('About'),
                  content: const Text(
                      'This is a hobby project made in Flutter by Harish'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text('okay'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
