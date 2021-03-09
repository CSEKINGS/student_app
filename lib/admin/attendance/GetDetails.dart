import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'AddDetails.dart';
import 'DbAndRefs.dart';
import 'Operations.dart';

class GetDetails extends StatefulWidget {
  final String text;

  GetDetails(this.text);

  @override
  _GetDetailsState createState() => _GetDetailsState();
}

class _GetDetailsState extends State<GetDetails> {
  List<Contents> year = [];
  List<Contents> department = [];
  String yer, dep, cls;
  DbRef obj = DbRef();

  @override
  void initState() {
    super.initState();
    CollectionReference yearRef = obj.getDetailRef('year');
    CollectionReference depRef = obj.getDetailRef('department');
    yearRef.snapshots().listen((event) {
      setState(() {
        for (int i = 0; i < event.docs.length; i++) {
          year.add(Contents.fromSnapshot(event.docs[i]));
        }
      });
    });
    depRef.snapshots().listen((event) {
      if (mounted) {
        setState(() {
          for (int i = 0; i < event.docs.length; i++) {
            department.add(Contents.fromSnapshot(event.docs[i]));
          }
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        children: <Widget>[
          DropdownButton(
            hint: Text('select year'),
            onChanged: (name) {
              setState(() {
                yer = name;
              });
            },
            value: yer,
            items: year
                .map((e) => DropdownMenuItem(
                      child: Text(e.name),
                      value: e.name,
                    ))
                .toList(),
          ),
          DropdownButton(
            hint: Text('select department'),
            onChanged: (name) {
              setState(() {
                dep = name;
              });
            },
            value: dep,
            items: department
                .map((e) => DropdownMenuItem(
                      child: Text(e.name),
                      value: e.name,
                    ))
                .toList(),
          ),
          TextButton(
            style: ButtonStyle(),
            child: Text(
              'Enter',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            onPressed: () {
              if (widget.text == 'Attendance') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Attendance(yer, dep, widget.text)));
              } else if (widget.text == 'Add class') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddDetails(yer, dep)));
              } else if (widget.text == 'Delete students') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Attendance(yer, dep, widget.text)));
              } else if (widget.text == 'Delete class') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Attendance(yer, dep, widget.text)));
              }
            },
          )
        ],
      ),
    );
  }
}
