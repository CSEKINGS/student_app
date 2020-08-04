import 'package:flutter/material.dart';
import 'package:student_app/admin/attendance/Dialog.dart';
import 'AddDetails.dart';
import 'Operations.dart';

class CustomView extends StatefulWidget {
  final String text;
  CustomView(this.text);

  @override
  _CustomViewState createState() => _CustomViewState();
}

class _CustomViewState extends State<CustomView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.cyanAccent,
      onTap: () {
        if (widget.text == 'Add class') {
          showDialog(
              context: context,
              builder: (BuildContext con) {
                return DialogBox('Add class');
              });
        } else if (widget.text == 'Add year') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddDetails('year', null)));
        } else if (widget.text == 'Add dep') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddDetails(null, 'department')));
        } else if (widget.text == 'Delete students') {
          showDialog(
              context: context,
              builder: (BuildContext con) {
                return DialogBox('Delete students');
              });
        } else if (widget.text == 'Delete class') {
          showDialog(
              context: context,
              builder: (BuildContext con) {
                return DialogBox('Delete class');
              });
        } else if (widget.text == 'Delete department') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Attendance(null, null, widget.text)));
        } else if (widget.text == 'Delete year') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Attendance(null, null, widget.text)));
        }
      },
      child: Column(
        children: <Widget>[
          Text(widget.text),
        ],
      ),
    );
  }
}
