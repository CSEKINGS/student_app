import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_app/admin/attendance/DbAndRefs.dart';

class classes extends StatefulWidget {
  @override
  _classesState createState() => _classesState();
}

class _classesState extends State<classes> {
  String cls;
  List<Contents> classes = List();
  Dbref obj = new Dbref();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CollectionReference reference;
    reference = obj.getDetailRef2(widget.yer, widget.dep);
    reference.snapshots().listen((event) {
      setState(() {
        for (int i = 0; i < event.documents.length; i++) {
          classes.add(Contents.fromSnapshot(event.documents[i]));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: Text('select class'),
      onChanged: (name) {
        setState(() {
          cls = name;
        });
      },
      value: cls,
      items: classes
          .map((e) => DropdownMenuItem(
                child: Text(e.name),
                value: e.name,
              ))
          .toList(),
    );
  }
}
