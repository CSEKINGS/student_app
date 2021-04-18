import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/admin/Models/db_model.dart';

class Dashboard extends StatefulWidget {
  List details = [];
  var days;

  Dashboard(this.details, this.days);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Future<SharedPreferences> _preference = SharedPreferences.getInstance();
  final references = FirebaseFirestore.instance;

  List<Contents> workingDays = [];
  var presentDays;
  double percentage;
  var displayPercent;
  Future percents;

  Future<bool> getDays() async {
    var ref1 = references
        .collection('collage')
        .doc('attendance')
        .collection(widget.details[8])
        .doc(widget.details[5])
        .collection(widget.details[11])
        .doc(widget.details[2]);
    ref1.snapshots().listen((event) {
      percentage = event.data()['total'].toDouble() / widget.days;
      displayPercent = NumberFormat('##.0#', 'en_US').format(percentage * 100);
    });
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: getDays(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Card(
                        elevation: 1.5,
                        margin: EdgeInsets.all(15.0),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: InkWell(
                            customBorder: CircleBorder(),
                            splashColor: Colors.indigoAccent,
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext con) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      title: Text('Details'),
                                      content: Container(
                                        height: 50,
                                        child: Text(
                                            'Total number of days :  ${widget.days}'
                                            '\n'
                                            'No of Present days : $presentDays'),
                                      ),
                                    );
                                  });
                            },
                            child: CircularPercentIndicator(
                              animation: true,
                              animationDuration: 1200,
                              lineWidth: 10.0,
                              percent: percentage,
                              backgroundColor: Colors.teal,
                              progressColor: Colors.deepOrange,
                              radius: 100.0,
                              circularStrokeCap: CircularStrokeCap.butt,
                              center: Text(
                                '$displayPercent' '%',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              footer: Text('Attendance Percentage',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        final preference = await _preference;
                        await preference.remove('username');
                        await preference.remove('foundedclass');
                        await SystemNavigator.pop();
                      },
                      child: Text('Logout'),
                    ),
                  ],
                );
              }

              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
