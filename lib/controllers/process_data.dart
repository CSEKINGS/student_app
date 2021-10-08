import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/views/student/student_widgets.dart';

/// this is the initial state which fetches info related to starting the app
class ProcessData extends StatefulWidget {
  final String? _regno, foundclass;

  const ProcessData(this._regno, this.foundclass);

  @override
  _ProcessDataState createState() => _ProcessDataState();
}

class _ProcessDataState extends State<ProcessData> {
  final reference = FirebaseFirestore.instance;
  String? _batch, _dept;
  List<String> details = [];
  final Future<SharedPreferences> _preference = SharedPreferences.getInstance();

  Future<List> stream() async {
    final preference = await _preference;
    await preference.setString('username', widget._regno!);
    await preference.setString('foundedclass', widget.foundclass!);

    _batch = '20${widget._regno!.substring(4, 6)}';
    _dept = widget._regno!.substring(6, 9);
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

    reference
        .collection('collage')
        .doc('student')
        .collection(_dept!)
        .doc(_batch)
        .collection(widget.foundclass!)
        .doc(widget._regno)
        .snapshots()
        .listen((event) async {
      details
        ..add(event.data()!['Name'])
        ..add(event.data()!['Rollno'])
        ..add(event.data()!['Regno'])
        ..add(event.data()!['PhoneNo'])
        ..add(event.data()!['DOB'])
        ..add(event.data()!['Batch'])
        ..add(event.data()!['Email'])
        ..add(event.data()!['BloodGroup'])
        ..add(event.data()!['Department'])
        ..add(event.data()!['Address'])
        ..add(event.data()!['ProfileUrl'])
        ..add(event.data()!['Class']);

      reference
          .collection('collage')
          .doc('date')
          .collection('working')
          .snapshots()
          .listen((event) {
        var days = 0;
        for (var i = 0; i < event.docs.length; i++) {
          days = days + 1;
          // setState(() {
          //   workingdays.add(Contents.fromSnapshot(event.documents[i]));
          // });
          // print('$days' + '********');
        }
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => StudentBottomNav(details:details, days:days)),
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
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
