import 'package:flutter/material.dart';
import 'package:student_app/admin/attendance/Designs.dart';
import 'package:student_app/admin/attendance/Dialog.dart';

class AttendanceEntry extends StatefulWidget {
  @override
  _AttendanceEntryState createState() => _AttendanceEntryState();
}

class _AttendanceEntryState extends State<AttendanceEntry> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                CustomView('Add class'),
                CustomView('Add student'),
                CustomView('Add year'),
                CustomView('Add dep'),
                CustomView('Delete students'),
                CustomView('Delete class'),
                CustomView('Delete department'),
                CustomView('Delete year'),
                FlatButton(
                  child:Text('Attendance'),
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (context){
                          return DialogBox();
                        }
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
