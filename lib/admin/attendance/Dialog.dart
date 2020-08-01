import 'package:flutter/material.dart';
import 'GetDetails.dart';

class DialogBox extends StatefulWidget {
  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      title: Text('Details'),
      content: Container(
        height: 145,
        child: GetDetails('Attendance'),
      ),
    );
  }
}
