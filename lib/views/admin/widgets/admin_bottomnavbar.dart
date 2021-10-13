import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_app/views/admin/admin_screens.dart';
import 'package:student_app/views/common/common_screens.dart';

import 'dialog.dart';

class AdminBottomNav extends StatefulWidget {
  @override
  _AdminBottomNavState createState() => _AdminBottomNavState();
}

class _AdminBottomNavState extends State<AdminBottomNav> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const DialogBox('Attendance'),
    MarkEntry(),
    const UploadNotes(),
    UploadProfile(),
    const SettingsPage(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        title: const Text(
          'Do you want to exit..?',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        actions: <Widget>[
          CloseButton(
            onPressed: () => Navigator.of(context).pop(false),
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          IconButton(
            onPressed: () async {
              await SystemNavigator.pop();
            },
            icon: const Icon(
              Icons.check,
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    ).then((value) => value);
  }

  @override
  void didChangeDependencies() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTappedBar,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.check_box),
              label: 'Attendance',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_add_alt_1_outlined),
              label: 'Admin',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.upload_outlined),
              label: 'Notes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_upload_outlined),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.extension_outlined),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}
