import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/admin/attendance/DbAndRefs.dart';

import 'package:percent_indicator/percent_indicator.dart';

class Dashboard extends StatefulWidget {
  List details = [];
  Dashboard(this.details);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<SharedPreferences> _preference = SharedPreferences.getInstance();
  final references = Firestore.instance;

  List<Contents> workingdays = List();
  var presentdays;
  double days = 0.0, percentage;
  var displaypercent;
  bool oncomplete = false;

  getdays() async {
    var ref2 =
        references.collection('collage').document('date').collection('working');
    ref2.snapshots().listen((event) {
      for (int i = 0; i < event.documents.length; i++) {
        days = days + 1;
        // setState(() {
        //   workingdays.add(Contents.fromSnapshot(event.documents[i]));
        // });
      }
      var ref1 = references
          .collection('collage')
          .document('attendance')
          .collection(widget.details[8])
          .document(widget.details[5])
          .collection(widget.details[11])
          .document(widget.details[2]);
      ref1.snapshots().listen((event) {
        presentdays = event.data['total'];
        print(presentdays.runtimeType);
        print('*******************');
        print(days.runtimeType);
        // print('$presentdays' + 'presentdays'); //print stmt
        presentdays = presentdays.toDouble();
        percentage = presentdays / days;
        print(percentage);
        // print('$percentage' + 'percentage');
        displaypercent = percentage * 100;
        print(displaypercent);
        oncomplete = true;
      });
    });
    // return days;
  }

  @override
  void initState() {
    super.initState();
    getdays();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: CircularPercentIndicator(
                percent: percentage,
                backgroundColor: Colors.teal,
                progressColor: Colors.deepOrange,
                radius: 100,
                center: Text('$displaypercent' + '%'),
              ),
            ),
            OutlineButton(
              onPressed: () async {
                final SharedPreferences preference = await _preference;
                await preference.remove('username');
                await preference.remove('foundedclass');
                SystemNavigator.pop();
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
