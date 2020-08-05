import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/student/widgets/student_bottomnavbar.dart';
import 'login.dart';

class ProcessData extends StatefulWidget {
  final String _regno;

  ProcessData(this._regno);

  @override
  _ProcessDataState createState() => _ProcessDataState();
}

class _ProcessDataState extends State<ProcessData> {
  final reference = Firestore.instance;

  String _batch, _dept;
  LoginPage kd = new LoginPage();
  // Future<String> storeuser;

  List details = [];
  Future<SharedPreferences> _preference = SharedPreferences.getInstance();

  Future<List> stream() async {
    final SharedPreferences preference = await _preference;
    await preference.setString('username', widget._regno);

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
        .document('student')
        .collection(_dept)
        .where('Regno', isEqualTo: '${widget._regno}')
        // .document(_batch)
        .snapshots();
    // .collection('103')
    // .document(widget._regno)
    // .snapshots(); //college,student,dept,batch,class,regno
    // .document(_dept)
    // .collection(_batch)
    // .document(widget._regno)
    // .snapshots();
    reff.listen((event) async {
      var datam = event.documents[0];

      // var ff = event.documents[0];
      // if (event.data[widget._regno] == widget._regno) {
      // print('listened');
      // Map data = event.data[widget._regno];
      // print(data);
      details.add(datam['Name']);
      details.add(datam['Rollno']);
      details.add(datam['Regno']);
      details.add(datam['PhoneNo']);
      details.add(datam['DOB']);
      details.add(datam['Batch']);
      details.add(datam['Email']);
      details.add(datam['BloodGroup']);
      details.add(datam['Department']);
      details.add(datam['Address']);
      details.add(datam['ProfileUrl']);
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
