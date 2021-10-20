import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_app/views/common/common_screens.dart';
import 'package:student_app/views/student/student_screens.dart';

class StudentBottomNav extends StatefulWidget {
  final List<String> details;
  final int days;

  StudentBottomNav({required this.details, required this.days});

  @override
  _StudentBottomNavState createState() => _StudentBottomNavState();
}

class _StudentBottomNavState extends State<StudentBottomNav> {
  int _currentIndex = 0;

  Future<List>? getList;

  Future<bool> _onBackPressed() async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
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
        );
      },
    ).then((value) => value ?? false);
  }

  @override
  void initState() {
    super.initState();
    _children = [
      Dashboard(details: widget.details, days: widget.days),
      Grade(),
      Profile(details: widget.details),
      Notes(),
      const SettingsPage(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    widget.details.clear();
  }

  late List<Widget> _children;

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in_outlined),
            label: 'Grade',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_drive_file_outlined),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.extension_outlined),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
