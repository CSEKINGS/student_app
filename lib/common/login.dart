import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_app/admin/widgets/admin_bottomnavbar.dart';
import 'package:student_app/student/widgets/student_bottomnavbar.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String uname, _batch, _dept, _regno, email, password;
  var sub;
  Map data;
  final reference = Firestore.instance;
  var details = [];
  TextEditingController _uname = TextEditingController();
  String bname;
  String initialname;

  stream() {
    _batch = '20' + initialname.substring(4, 6);
    _dept = initialname.substring(6, 9);
    _regno = initialname;
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
      default:
        {
          print('Details');
        }
    }
    print('Switch run successfully');
    sub = reference
        .collection('student')
        .document(_dept)
        .collection(_batch)
        .document(_regno)
        .snapshots();
        sub.listen((event) {
      data = event.data;
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
    });

    print('state run successfully');
  }

  Widget vldfrm() {
    return TextFormField(
      controller: _uname,
      decoration: InputDecoration(
          filled: true,
          labelText: "Username",
          hintStyle: TextStyle(
              color: Colors.grey,
              fontFamily: "Poppins-Medium",
              fontSize: ScreenUtil.getInstance().setSp(26))),
      validator: (String value) {
        if ((value.isEmpty) || (!RegExp(r"^[0-9]{12}$").hasMatch(value))) {
          initialname = value;
          return 'Invalid Details';
        }
        return null;
      },
      onSaved: (String input) {
        uname = input.toString();
      },
    );
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );
  final _logkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Image.asset("assets/image_01.png"),
              ),
              Expanded(
                child: Container(),
              ),
              Expanded(child: Image.asset("assets/image_02.png"))
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/collage_logo.png",
                        width: ScreenUtil.getInstance().setWidth(150),
                        height: ScreenUtil.getInstance().setHeight(150),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(180),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: 1),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 15.0),
                              blurRadius: 15.0),
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, -10.0),
                              blurRadius: 10.0),
                        ]),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                      child: Form(
                        key: _logkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Login",
                                style: TextStyle(
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(45),
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6)),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            vldfrm(),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue)),
                                labelText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "Poppins-Medium",
                                  fontSize: ScreenUtil.getInstance().setSp(26),
                                ),
                              ),
                              validator: (String input) {
                                if (input != password) {
                                  return 'Password is incorrect';
                                }
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          StudentBottomNav(details)),
                                );
                                return null;
                              },
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(60),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          child: Container(
                            width: ScreenUtil.getInstance().setWidth(330),
                            height: ScreenUtil.getInstance().setHeight(100),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xFF17ead9),
                                  Color(0xFF6078ea)
                                ]),
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFF6078ea).withOpacity(.3),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => AdminBottomNav()),
                                  );
                                },
                                child: Center(
                                  child: Text("Admin",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins-Bold",
                                          fontSize: 18,
                                          letterSpacing: 1.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Container(
                            width: ScreenUtil.getInstance().setWidth(330),
                            height: ScreenUtil.getInstance().setHeight(100),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xFF17ead9),
                                  Color(0xFF6078ea)
                                ]),
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0,
                                  )
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  stream();
                                   if (_logkey.currentState.validate() && details.isNotEmpty) {
      _logkey.currentState.save();
    }
                                },
                                child: Center(
                                  child: Text("Student",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins-Bold",
                                          fontSize: 18,
                                          letterSpacing: 1.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
