import 'package:flutter/material.dart';
// import 'package:http/io_client.dart';
import 'package:student_app/student/screens/dashboard.dart';
import 'package:student_app/student/screens/grade.dart';
import 'package:student_app/student/screens/profile.dart';
import 'package:student_app/student/screens/view_notes.dart';


class StudentBottomNav extends StatefulWidget {
  String _college;
  String _batch;
  String _dept;
  String _rollno;

  StudentBottomNav(this._college,this._batch,this._dept,this._rollno);

  @override
  _StudentBottomNavState createState() => _StudentBottomNavState(_college,_batch,_dept,_rollno);
}

class _StudentBottomNavState extends State<StudentBottomNav> {
  int _currentIndex = 0;
  String _college;
  String _batch;
  String _dept;
  String _rollno;
  _StudentBottomNavState(this._college,this._batch,this._dept,this._rollno);
  
  //  static String rr,cc,dd,bb;

@override

  void initState()  {
     print('820611'+'${widget._dept}'+'${widget._batch}'+'${widget._rollno}');
    // TODO: implement initState
    super.initState();
    _children=  [
    Dashboard(),
    Grade(),
    Profile(_college,_batch,_dept,_rollno),
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
