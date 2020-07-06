import 'package:flutter/material.dart';
import 'package:student_app/admin/screens/attendanceentry.dart';
import 'package:student_app/admin/screens/markentry.dart';
import 'package:student_app/admin/screens/uploadnotes.dart';
import 'package:student_app/admin/screens/uploadprofile.dart';

class AdminBottomNav extends StatefulWidget {
  @override
  _AdminBottomNavState createState() => _AdminBottomNavState();
}

class _AdminBottomNavState extends State<AdminBottomNav> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    AttendanceEntry(),
    MarkEntry(),
    UploadNotes(),
    UploadProfile(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            title: Text('Grade'),
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
    );
  }
}
