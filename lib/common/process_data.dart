import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/student/widgets/student_bottomnavbar.dart';

class ProcessData extends StatefulWidget {
  final String _regno, foundclass;

  ProcessData(this._regno, this.foundclass);

  @override
  _ProcessDataState createState() => _ProcessDataState();
}

class _ProcessDataState extends State<ProcessData> {
  final reference = FirebaseFirestore.instance;
  String _batch, _dept;
  List details = [];
  final Future<SharedPreferences> _preference = SharedPreferences.getInstance();

  Future<List> stream() async {
    var days;
    final preference = await _preference;
    await preference.setString('username', widget._regno);
    await preference.setString('foundedclass', widget.foundclass);

    _batch = '20' + widget._regno.substring(4, 6);
    _dept = widget._regno.substring(6, 9);
    switch (_dept) {
      case '101':
        {
          _dept = 'AE';
        }
        break;
      case '102':
        {
          _dept = 'AUTOMOBILE';
        }
        break;
      case '103':
        {
          _dept = 'CIVIL';
        }
        break;
      case '104':
        {
          _dept = 'CSE';
        }
        break;
      case '105':
        {
          _dept = 'EEE';
        }
        break;
      case '106':
        {
          _dept = 'ECE';
        }
        break;
      case '114':
        {
          _dept = 'MECH';
        }
        break;
      case '121':
        {
          _dept = 'BIOMEDICAL';
        }
        break;
    }

    var reff = reference
        .collection('collage')
        .doc('student')
        .collection(_dept)
        .doc(_batch)
        .collection(widget.foundclass)
        .doc(widget._regno)
        .snapshots();
    reff.listen((event) async {
      details.add(event.data()['Name']);
      details.add(event.data()['Rollno']);
      details.add(event.data()['Regno']);
      details.add(event.data()['PhoneNo']);
      details.add(event.data()['DOB']);
      details.add(event.data()['Batch']);
      details.add(event.data()['Email']);
      details.add(event.data()['BloodGroup']);
      details.add(event.data()['Department']);
      details.add(event.data()['Address']);
      details.add(event.data()['ProfileUrl']);
      details.add(event.data()['Class']);
      var ref2 =
          reference.collection('collage').doc('date').collection('working');
      ref2.snapshots().listen((event) {
        days = 0;
        for (var i = 0; i < event.docs.length; i++) {
          days = days + 1;
          // setState(() {
          //   workingdays.add(Contents.fromSnapshot(event.documents[i]));
          // });
          // print('$days' + '********');
        }
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => StudentBottomNav(details, days)),
        );
      });
    });
    return details;
  }

  void getTotalDays() {}

  @override
  void initState() {
    super.initState();
    getTotalDays();
    stream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
