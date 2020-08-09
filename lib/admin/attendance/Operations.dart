import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'DbAndRefs.dart';

class Attendance extends StatefulWidget {
  final String yer, dep, text;

  Attendance(this.yer, this.dep, this.text);

  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  String cls;
  List<Contents> classes = List();
  List<Item> item = List();
  DbRef obj = DbRef();

  @override
  void initState() {
    super.initState();
    CollectionReference reference;
    if (widget.text == 'Delete students' ||
        widget.text == 'Attendance' ||
        widget.text == 'Delete class') {
      reference = obj.getDetailRef2(widget.yer, widget.dep);
      reference.snapshots().listen((event) {
        setState(() {
          for (int i = 0; i < event.documents.length; i++) {
            classes.add(Contents.fromSnapshot(event.documents[i]));
          }
        });
      });
    } else if (widget.text == 'Delete department') {
      setState(() {
        reference = obj.getDetailRef('department');
        reference.snapshots().listen((event) {
          setState(() {
            for (int i = 0; i < event.documents.length; i++) {
              classes.add(Contents.fromSnapshot(event.documents[i]));
            }
          });
        });
      });
    } else if (widget.text == 'Delete year') {
      setState(() {
        reference = obj.getDetailRef('year');
        reference.snapshots().listen((event) {
          setState(() {
            for (int i = 0; i < event.documents.length; i++) {
              classes.add(Contents.fromSnapshot(event.documents[i]));
            }
          });
        });
      });
    }
  }

  void _clearData() {
    setState(() {
      item.clear();
    });
  }

  void _clearData1() {
    setState(() {
      classes.clear();
    });
  }

  void _getStudent() {
    _clearData();
    CollectionReference ref = obj.getProfile(cls, widget.yer, widget.dep);
    ref.snapshots().listen((event) {
      setState(() {
        for (int i = 0; i < event.documents.length; i++) {
          item.add(Item.fromSnapshot(event.documents[i]));
        }
      });
    });
  }

  void _addAttendance(var hour) {
    CollectionReference ref1 = obj.placeAttendance(cls, widget.yer, widget.dep);
    var period, total;
    switch (hour) {
      case '09':
        {
          period = 1;
        }
        break;
      case '10':
        {
          period = 2;
        }
        break;
      case '11':
        {
          period = 3;
        }
        break;
      case '12':
        {
          period = 4;
        }
        break;
      case '13':
        {
          period = 5;
        }
        break;
      case '14':
        {
          period = 6;
        }
        break;
      case '15':
        {
          period = 7;
        }
        break;
      case '16':
        {
          period = 8;
        }
        break;
    }
    for (int i = 0; i < item.length; i++) {

      ref1.document(item[i].key).get().then((value) {
        for (int j = 1; j < 11; j++) {
          if (value.data['$j'] == 'present') {
            if (value.data['total']!=null){
              ref1.document(item[i].key).updateData({'total': value.data['total']+1});
            }
            else if(value.data['total']==null){
              ref1.document(item[i].key).setData({
                'Roll-no': item[i].rollNo,
                'name': item[i].name,
                '$period': item[i].isSelected ? 'present' : 'absent',
                'total': 1
              });
            }
          }
        }
      });
    }
  }

  void addDate(var date, var hour) {
    CollectionReference ref = obj.getDates();
    ref.add({'name': '$date'});
    _addAttendance(hour);
  }
  var hasdate;
  void checker() {
    var datetime = DateTime.now().toString();
    var dateParse = DateTime.parse(datetime);
    var date = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    var hour = "${dateParse.hour}";
    CollectionReference ref = obj.getDates();
    ref.getDocuments().then((value){
      for(int i=0;i<value.documents.length;i++){
        if(value.documents[i].data['name']==date){
          _addAttendance(hour);
          hasdate='yes';
        }
      }
      if(hasdate!='yes'){
        addDate(date, hour);
      }
    });
  }

  void _delete() {
    CollectionReference ref1 = obj.getProfile(cls, widget.yer, widget.dep);
    for (int i = 0; i < item.length; i++) {
      if (item[i].isSelected) {
        ref1.document(item[i].key).delete();
      }
    }
  }

  void _deleteDep() {
    CollectionReference ref1 = obj.getDetailRef('department');
    for (int i = 0; i < classes.length; i++) {
      if (classes[i].isSelected) {
        ref1.document(classes[i].key).delete();
      }
    }
  }

  void _deleteYear() {
    CollectionReference ref1 = obj.getDetailRef('year');
    for (int i = 0; i < classes.length; i++) {
      if (classes[i].isSelected) {
        ref1.document(classes[i].key).delete();
      }
    }
  }

  void _deleteClass() {
    CollectionReference ref1 = obj.getDetailRef2(widget.yer, widget.dep);
    for (int i = 0; i < classes.length; i++) {
      if (classes[i].isSelected) {
        ref1.document(classes[i].key).delete();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Selections'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            (widget.text == 'Delete students' || widget.text == 'Attendance')
                ? DropdownButton(
                    hint: Text('select class'),
                    onChanged: (name) {
                      setState(() {
                        cls = name;
                        _getStudent();
                      });
                    },
                    value: cls,
                    items: classes
                        .map((e) => DropdownMenuItem(
                              child: Text(e.name),
                              value: e.name,
                            ))
                        .toList(),
                  )
                : Container(),
            (widget.text == 'Delete students' || widget.text == 'Attendance')
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(10),
                    itemCount: item.length,
                    itemBuilder: (context, int index) => Container(
                        color: item[index].isSelected
                            ? Colors.lightBlueAccent
                            : Colors.white,
                        child: ListTile(
                          title: Text(item[index].name),
                          subtitle: Text(item[index].rollNo),
                          onTap: () {
                            setState(() {
                              item[index].isSelected = false;
                            });
                          },
                          onLongPress: () {
                            setState(() {
                              item[index].isSelected = true;
                            });
                          },
                        )))
                : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(10),
                    itemCount: classes.length,
                    itemBuilder: (context, int index) => Container(
                        color: classes[index].isSelected
                            ? Colors.lightBlueAccent
                            : Colors.white,
                        child: ListTile(
                          title: Text(classes[index].name),
                          onTap: () {
                            setState(() {
                              classes[index].isSelected = false;
                            });
                          },
                          onLongPress: () {
                            setState(() {
                              classes[index].isSelected = true;
                            });
                          },
                        ))),
            RaisedButton(
              child: Text('Submit'),
              color: Colors.lightBlueAccent,
              onPressed: () {
                if (widget.text == 'Delete students') {
                  _delete();
                  _clearData();
                } else if (widget.text == 'Attendance') {
                  checker();
                } else if (widget.text == 'Delete department') {
                  _deleteDep();
                  _clearData1();
                } else if (widget.text == 'Delete year') {
                  _deleteYear();
                  _clearData1();
                } else if (widget.text == 'Delete class') {
                  _deleteClass();
                  _clearData1();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
