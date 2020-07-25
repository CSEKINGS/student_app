import 'package:flutter/material.dart';
import 'package:student_app/attendance/Designs.dart';

class AttendanceEntry extends StatefulWidget {
  @override
  _AttendanceEntryState createState() => _AttendanceEntryState();
}

class _AttendanceEntryState extends State<AttendanceEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Attendance entry'),
      ),
      drawer: Container(
        width: 210,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                 gradient: LinearGradient(colors: <Color>[
                   Colors.lightBlue,
                   Colors.lightBlueAccent
                  ])
                 ),
                 child: Container(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                      Text('Header',style: TextStyle(fontSize: 20),),
                      ],
                   ),
                 ),
              ),
             CustomView('Add class'),
             CustomView('Add student'),
             CustomView('Attendance'),
             CustomView('Add year'),
             CustomView('Add dep'),
             CustomView('Delete students'),
             CustomView('Delete class'),
             CustomView('Delete department'),
             CustomView('Delete year'),
          ],
        ),
       ),
      )
    );
  }
}
