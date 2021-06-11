import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_app/common/settings.dart';
import 'package:student_app/student/screens/dashboard.dart';
import 'package:student_app/student/screens/grade.dart';
import 'package:student_app/student/screens/profile.dart';
import 'package:student_app/student/screens/view_notes.dart';

class StudentBottomNav extends StatefulWidget {
  final List details;
  final days;

  StudentBottomNav(this.details, this.days);

  @override
  _StudentBottomNavState createState() => _StudentBottomNavState(details);
}

class _StudentBottomNavState extends State<StudentBottomNav> {
  _StudentBottomNavState(this.details);
  int _currentIndex = 0;
  List details;
  Future<List> getList;
  var storeValue;

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
        ) ??
        false;
  }

  @override
  void initState() {
    super.initState();
    _children = [
      Dashboard(details, widget.days),
      Grade(details),
      Profile(details),
      Notes(),
      SettingsPage(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    details.clear();
  }

  List<Widget> _children;

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _children,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTappedBar,
          currentIndex: _currentIndex,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Dashboard',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.assignment_turned_in_outlined),
              label: 'Grade',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: 'Profile',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.insert_drive_file_outlined),
              label: 'Notes',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.extension_outlined),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}
