import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'DbAndRefs.dart';

// ignore: must_be_immutable
class AddStudent extends StatefulWidget {
  String dep, yer;
  AddStudent(this.yer, this.dep);

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  TextEditingController eCtrl = new TextEditingController();
  TextEditingController eCtrl1 = new TextEditingController();
  String name, age, cls;
  DbRef obj = new DbRef();
  List<Contents> classes = List();

  @override
  void initState() {
    super.initState();
    CollectionReference clsRef = obj.getDetailRef2(widget.yer, widget.dep);
    clsRef.snapshots().listen((event) {
      setState(() {
        for (int i = 0; i < event.documents.length; i++) {
          classes.add(Contents.fromSnapshot(event.documents[i]));
        }
      });
    });
  }

  void save() {
    CollectionReference ref = obj.getProfile(cls, widget.yer, widget.dep);
    ref.add({'name': eCtrl.value.text, 'age': eCtrl1.value.text.toString()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add student'),
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 200,
          child: Column(
            children: <Widget>[
              new Text('Name:'),
              new TextField(
                controller: eCtrl,
                onSubmitted: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              new Text('age:'),
              new TextField(
                controller: eCtrl1,
                onSubmitted: (value) {
                  setState(() {
                    age = value;
                  });
                },
              ),
              new DropdownButton(
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
              ),
              new FlatButton(
                child: Text('enter'),
                onPressed: () {
                  if (eCtrl.value.text != null &&
                      eCtrl1.value.text != null &&
                      cls != null) {
                    save();
                    eCtrl.clear();
                    eCtrl1.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
