import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/common/login.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<SharedPreferences> _preference = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Center(
              child: OutlineButton(
                onPressed: () async {
                  final SharedPreferences preference = await _preference;
                  await preference.remove('username');
                  await preference.remove('foundedclass');
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => LoginPage()),
                  );
                },
                child: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
