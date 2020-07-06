import 'package:flutter/material.dart';
import 'package:student_app/student/screens/dashboard.dart';
import 'package:student_app/student/screens/profile.dart';
import 'package:student_app/student/screens/viewnotes.dart';

class StudentBottomNav extends StatefulWidget {
  @override
  _StudentBottomNavState createState() => _StudentBottomNavState();
}

class _StudentBottomNavState extends State<StudentBottomNav> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Dashboard(),
    Profile(),
    Notes(),
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
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Dashboard'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync),
            title: Text('Notes'),
          ),
        ],
      ),
    );
  }
}
