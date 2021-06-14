import 'package:flutter/material.dart';

import '../logic/add_details.dart';
import '../logic/attendance.dart';
import 'dialog.dart';

class Designs extends StatefulWidget {
  final String text;

  const Designs(this.text);

  @override
  _DesignsState createState() => _DesignsState();
}

class _DesignsState extends State<Designs> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.black54,
      onTap: () {
        if (widget.text == 'Add class') {
          showDialog(
              context: context,
              builder: (BuildContext con) {
                return const DialogBox('Add class');
              });
        } else if (widget.text == 'Add year') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddDetails('year', null)));
        } else if (widget.text == 'Add dep') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddDetails(null, 'department')));
        } else if (widget.text == 'Delete students') {
          showDialog(
              context: context,
              builder: (BuildContext con) {
                return const DialogBox('Delete students');
              });
        } else if (widget.text == 'Delete class') {
          showDialog(
              context: context,
              builder: (BuildContext con) {
                return const DialogBox('Delete class');
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
      child: Card(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image(
              color: Colors.black54,
              height: 60,
              width: 60,
              fit: BoxFit.fill,
              alignment: Alignment.center,
              image: AssetImage('assets/${widget.text}.png'),
            ),
            Text(
              widget.text,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
