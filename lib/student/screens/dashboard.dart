import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/admin/attendance/DbAndRefs.dart';

class Dashboard extends StatefulWidget {
  List details = [];
  var days;
  Dashboard(this.details, this.days);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<SharedPreferences> _preference = SharedPreferences.getInstance();
  final references = Firestore.instance;

  List<Contents> workingdays = List();
  var presentdays;
  double percentage;
  var displaypercent;

  Future getdays() async {
    var ref1 = references
        .collection('collage')
        .document('attendance')
        .collection(widget.details[8])
        .document(widget.details[5])
        .collection(widget.details[11])
        .document(widget.details[2]);
    ref1.snapshots().listen((event) {
      presentdays = event.data['total'];
      presentdays = presentdays.toDouble();
      percentage = presentdays / widget.days;
      displaypercent = percentage * 100;
      final ff = NumberFormat('##.0#', 'en_US');
      displaypercent = ff.format(displaypercent);
      print(displaypercent);
    });
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  alert() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: getdays(),
            builder: (buildContext, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: CircularPercentIndicator(
                        percent: percentage,
                        backgroundColor: Colors.teal,
                        progressColor: Colors.deepOrange,
                        radius: 100,
                        center: InkWell(
                            child: Text(
                              '$displaypercent' + '%',
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext con) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0)),
                                      title: Text('Details'),
                                      content: Container(
                                        height: 100,
                                        child: Text(
                                            'Total no. of Days :  ${widget.days}' +
                                                '\n' +
                                                'No of Present days : $presentdays'),
                                      ),
                                    );
                                  });
                            }),
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
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
