import 'package:flutter/material.dart';

import '../Models/db_model.dart';
import 'add_details.dart';
import 'attendance.dart';

class GetDetails extends StatefulWidget {
  final String text;

  const GetDetails(this.text);

  @override
  _GetDetailsState createState() => _GetDetailsState();
}

class _GetDetailsState extends State<GetDetails> {
  List<Contents> year = [];
  List<Contents> department = [];
  String? yer, dep, cls;
  DatabaseReference obj = DatabaseReference();

  @override
  void initState() {
    super.initState();
    var yearRef = obj.getDetailRef('year');
    var depRef = obj.getDetailRef('department');
    yearRef.snapshots().listen((event) {
      if (mounted) {
        setState(() {
          for (var i = 0; i < event.docs.length; i++) {
            year.add(Contents.fromSnapshot(event.docs[i]));
          }
        });
      }
    });
    depRef.snapshots().listen((event) {
      if (mounted) {
        setState(() {
          for (var i = 0; i < event.docs.length; i++) {
            department.add(Contents.fromSnapshot(event.docs[i]));
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DropdownButton(
          hint: const Text('select year'),
          onChanged: (dynamic name) {
            setState(() {
              yer = name;
            });
          },
          value: yer,
          items: year
              .map((e) => DropdownMenuItem(
                    value: e.name,
                    child: Text(e.name ?? "unknown"),
                  ))
              .toList(),
        ),
        DropdownButton(
          hint: const Text('select department'),
          onChanged: (String? name) {
            setState(() {
              dep = name;
            });
          },
          value: dep,
          items: department
              .map((e) => DropdownMenuItem(
                    value: e.name,
                    child: Text(e.name ?? "unknown"),
                  ))
              .toList(),
        ),
        TextButton(
          style: const ButtonStyle(),
          onPressed: () {
            if (widget.text == 'Attendance') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Attendance(yer, dep, widget.text)));
            } else if (widget.text == 'Add class') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddDetails(yer, dep)));
            } else if (widget.text == 'Delete students') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Attendance(yer, dep, widget.text)));
            } else if (widget.text == 'Delete class') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Attendance(yer, dep, widget.text)));
            }
          },
          child: const Text(
            'Enter',
            style: TextStyle(fontSize: 20.0),
          ),
        )
      ],
    );
  }
}
