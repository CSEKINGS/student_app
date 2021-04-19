import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void sign0utStaff() async {
    final _auth = FirebaseAuth.instance;
    await _auth.signOut();
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: OutlinedButton(
          onPressed: () => sign0utStaff(),
          child: Text('Sign Out'),
        ),
      ),
    );
  }
}
