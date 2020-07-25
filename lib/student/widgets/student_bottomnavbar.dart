import 'package:flutter/material.dart';
// import 'package:http/io_client.dart';
import 'package:student_app/student/screens/dashboard.dart';
import 'package:student_app/student/screens/grade.dart';
import 'package:student_app/student/screens/profile.dart';
import 'package:student_app/student/screens/view_notes.dart';


// ignore: must_be_immutable
class StudentBottomNav extends StatefulWidget {
String name,rollno,regno,phno,dob,batch,email,bloodgrp,department,address,profileurl;
List ccil;
  StudentBottomNav(this.ccil);
  @override
  _StudentBottomNavState createState() => _StudentBottomNavState(ccil);
}

class _StudentBottomNavState extends State<StudentBottomNav> {
  int _currentIndex = 0;
  List ccil;
  // String _college;
  // String _batch;
  // String _dept;
  // String _rollno;
  String name,rollno,regno,phno,dob,batch,email,bloodgrp,department,address,profileurl;
  _StudentBottomNavState(this.ccil);

  //  static String rr,cc,dd,bb;

@override

  void initState()  {
print('${ccil[0]}'+'######'+'${ccil[2]}');
  super.initState();
    _children=  [
    Dashboard(),
    Grade(),
    Profile(ccil),
    Notes(),
  ];
  

  }

   List<Widget> _children; 

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
    );
  }
}
