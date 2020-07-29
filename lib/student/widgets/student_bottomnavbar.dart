import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  Future<SharedPreferences> _preference = SharedPreferences.getInstance();

  _StudentBottomNavState(this.details);

  Future<void> sharedStore() async {
    final SharedPreferences preference = await _preference;
    setState(() {
      getList =
          preference.setStringList('details', details).then((bool success) {
        sharedGet();
        return getList;
      });
    });
  }

  Future<void> sharedGet() async {
    final SharedPreferences preference = await _preference;
    storeValue = preference.getStringList('details');
    print(storeValue);
    return storeValue;
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            title: Text(
              'Do you want to logout..?',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            actions: <Widget>[
              CloseButton(
                onPressed: () => Navigator.of(context).pop(false),
                color: Colors.red,
              ),
              SizedBox(height: 16),
              IconButton(
                onPressed: () => Navigator.of(context).pop(true),
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
    sharedStore();

    _children = [
      Dashboard(),
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
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTappedBar,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Dashboard'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Grade'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.file_download),
              title: Text('Notes'),
            ),
          ],
        ),
      ),
    );
  }
}
