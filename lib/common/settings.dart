import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/theme/theme.dart';
import 'package:student_app/theme/theme_notifier.dart';
import 'package:student_app/theme/theme_shared_pref.dart';

/// settings UI
class SettingsPage extends StatefulWidget {
  /// default constructor
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _darkTheme = true;
  final Future<SharedPreferences> _preference = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.brush_outlined),
              title: const Text('Theme'),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              onTap: () async {
                final _auth = FirebaseAuth.instance;
                await _auth.signOut();
                try {
                  final preference = await _preference;
                  await preference.remove('username');
                  await preference.remove('foundedclass');
                } catch (e) {
                  print(e);
                }
                await SystemNavigator.pop();
              },
            ),
            const Spacer(),
            const Center(
              child: Text(
                'Made with ❤ by CSEKINGS',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
