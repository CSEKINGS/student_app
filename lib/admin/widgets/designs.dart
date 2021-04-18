import 'package:flutter/material.dart';

import '../logic/AddDetails.dart';
import '../logic/Operations.dart';
import 'Dialog.dart';

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
      splashColor: Colors.black54,
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
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            8.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(
                0.0,
                10.0,
              ),
              blurRadius: 15.0,
            ),
            BoxShadow(
              color: Colors.black12,
              offset: Offset(
                0.0,
                -3.0,
              ),
              blurRadius: 10.0,
            ),
          ],
        ),
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
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
