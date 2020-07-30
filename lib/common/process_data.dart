import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/student/widgets/student_bottomnavbar.dart';

class process_data extends StatefulWidget {
  String _regno;
  process_data(this._regno);
  @override
  _process_dataState createState() => _process_dataState();
}

// ignore: camel_case_types
class _process_dataState extends State<process_data> {
  final reference = Firestore.instance;

  String _batch, _dept;
  // Future<String> storeuser;

  List details = [];
  Future<SharedPreferences> _preference = SharedPreferences.getInstance();
  Future<void> sharedStore() async {}

  Future<List> stream() async {
    final SharedPreferences preference = await _preference;
     await preference.setString('username', widget._regno);

    _batch = '20' + widget._regno.substring(4, 6);
    _dept = widget._regno.substring(6, 9);
    // ignore: await_only_futures
    await reference
        .collection('student')
        .document(_dept)
        .collection(_batch)
        .document(widget._regno)
        .snapshots()
        .listen((event) async {
      // print('listened');
      Map data = event.data;
      details.add(data['Name']);
      details.add(data['Rollno']);
      details.add(data['Regno']);
      details.add(data['PhoneNo']);
      details.add(data['DOB']);
      details.add(data['Batch']);
      details.add(data['Email']);
      details.add(data['BloodGroup']);
      details.add(data['Department']);
      details.add(data['Address']);
      details.add(data['ProfileUrl']);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => StudentBottomNav(details)),
      );
    });
    return details;
  }

  @override
  void initState() {
    super.initState();
    stream();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
