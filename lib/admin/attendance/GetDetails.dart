import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Operations.dart';
import 'AddStd.dart';
import 'DbAndRefs.dart';
import 'AddDetails.dart';

// ignore: must_be_immutable
class GetDetails extends StatefulWidget {
  String text;
  GetDetails(this.text);
  @override
  _GetDetailsState createState() => _GetDetailsState();
}

class _GetDetailsState extends State<GetDetails> {
  List<Contents> year = List();
  List<Contents> department = List();
  String yer, dep, cls;
  Dbref obj = new Dbref();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CollectionReference yearRef = obj.getDetailRef('year');
    CollectionReference depRef = obj.getDetailRef('department');
    yearRef.snapshots().listen((event) {
      setState(() {
        for (int i = 0; i < event.documents.length; i++) {
          year.add(Contents.fromSnapshot(event.documents[i]));
        }
      });
    });
    depRef.snapshots().listen((event) {
      setState(() {
        for (int i = 0; i < event.documents.length; i++) {
          department.add(Contents.fromSnapshot(event.documents[i]));
        }
      });
    });
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
          FlatButton(
            color: Colors.black,
            textColor: Colors.white,
            child: Text(
              'Enter',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {
              if (widget.text == 'Attendance') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Attendance(yer, dep, widget.text)));
              } else if (widget.text == 'Add student') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddStudent(yer, dep)));
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
