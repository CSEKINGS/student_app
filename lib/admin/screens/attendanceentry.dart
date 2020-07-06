import 'package:flutter/material.dart';

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
    );
  }
}
