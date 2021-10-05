import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:student_app/admin/Models/db_model.dart';

class Dashboard extends StatefulWidget {
  Dashboard(this.details, this.days);

  final List<String>? details;
  final int days;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final references = FirebaseFirestore.instance;

  List<Contents> workingDays = [];
  int? presentDays;
  double percentage = 0.0;
  String? displayPercent;
  Future? percents;

  Future<bool> getDays() async {
    var ref1 = references
        .collection('collage')
        .doc('attendance')
        .collection(widget.details?[8] ?? "unknown")
        .doc(widget.details?[5] ?? "unknown")
        .collection(widget.details?[11] ?? "unknown")
        .doc(widget.details?[2] ?? "unknown");
    ref1.snapshots().listen((event) {
      setState(() {
        percentage = double.parse(event.data()?['total'].toString() ?? "1") /
                widget.days ??
            1.0;
        displayPercent =
            NumberFormat('##.0#', 'en_US').format(percentage * 100);
      });
    });
    return true;
  }

  @override
  void initState() {
    super.initState();
    percents = getDays();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<dynamic>(
            future: percents,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 15.0),
                      child: Text('Attendance Percentage',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0)),
                    ),
                    Card(
                      elevation: 1.5,
                      margin: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                            ),
                          ),
                          Text('Total number of days:${widget.days}'
                              '\n'
                              'No of Present days: $presentDays'),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
