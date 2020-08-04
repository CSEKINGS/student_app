import 'package:flutter/material.dart';
import 'package:student_app/admin/attendance/Designs.dart';

class MarkEntry extends StatefulWidget {
  @override
  _MarkEntryState createState() => _MarkEntryState();
}

class _MarkEntryState extends State<MarkEntry> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 4 / 3,
          padding: EdgeInsets.all(8),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: <Widget>[
            CustomView('Add class'),
            CustomView('Add year'),
            CustomView('Add dep'),
            CustomView('Delete students'),
            CustomView('Delete class'),
            CustomView('Delete department'),
            CustomView('Delete year'),
          ],
        ),
      ),
    );
  }
}
