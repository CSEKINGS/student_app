import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_app/admin/attendance/Dialog.dart';
import 'package:student_app/admin/screens/mark_entry.dart';
import 'package:student_app/admin/screens/upload_notes.dart';
import 'package:student_app/admin/screens/upload_profile.dart';

class AdminBottomNav extends StatefulWidget {
  @override
  _AdminBottomNavState createState() => _AdminBottomNavState();
}

class _AdminBottomNavState extends State<AdminBottomNav> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    DialogBox('Attendance'),
    MarkEntry(),
    UploadNotes(),
    UploadProfile(),
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            title: Text(
              'Do you want to exit..?',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            actions: <Widget>[
              CloseButton(
                onPressed: () => Navigator.of(context).pop(false),
                color: Colors.red,
              ),
              SizedBox(height: 16),
              IconButton(
                onPressed: () async {
                  SystemNavigator.pop();
                },
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
        ) ??
        false;
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
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.check_box),
              title: Text('Attendance'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Admin'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.file_upload),
              title: Text('Notes'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_upload),
              title: Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
