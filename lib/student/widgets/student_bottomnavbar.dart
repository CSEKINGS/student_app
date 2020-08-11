import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:student_app/student/screens/dashboard.dart';
import 'package:student_app/student/screens/grade.dart';
import 'package:student_app/student/screens/profile.dart';
import 'package:student_app/student/screens/view_notes.dart';

class StudentBottomNav extends StatefulWidget {
  final List details;
  StudentBottomNav(this.details);

  @override
  _StudentBottomNavState createState() => _StudentBottomNavState(details);
}

class _StudentBottomNavState extends State<StudentBottomNav> {
  int _currentIndex = 0;
  List details;
  Future<List> getList;
  var storeValue;

  _StudentBottomNavState(this.details);

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
  void initState() {
    super.initState();

    _children = [
      Dashboard(details),
      Grade(details),
      Profile(details),
      Notes(),
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
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ]),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 10.0),
              child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                duration: Duration(milliseconds: 500),
                tabBackgroundColor: Colors.grey[800],
                onTabChange: onTappedBar,
                selectedIndex: _currentIndex,
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Dashboard',
                  ),
                  GButton(
                    icon: Icons.score,
                    text: 'Grade',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  ),
                  GButton(
                    icon: Icons.file_download,
                    text: 'Notes',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
