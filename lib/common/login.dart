import 'package:cloud_firestore/cloud_firestore.dart';
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
  String _batch, _dept, _regno, password;
  Map data;
  final reference = Firestore.instance;
  var details = [];
  TextEditingController _uname = TextEditingController();
  TextEditingController _pass = TextEditingController();
  String pword;
  String initialname;
  bool valid;
  bool _passwordVisible;
  Widget iconType;
  final _logkey = GlobalKey<FormState>();
  final snack = GlobalKey<ScaffoldState>();
  final ukey = GlobalKey<FormFieldState>();
  final passkey = GlobalKey<FormFieldState>();

  Future processdata() async {
    _logkey.currentState.save();
    formValidation(valid);
  }

  Future formValidation(valid) async {
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
    }
    reference
        .collection('student')
        .document(_dept)
        .collection(_batch)
        .document(_regno)
        .snapshots()
        .listen((event) async {
      data = event.data;
      if (data == null) {
        setState(() {
          iconType = Icon(
            Icons.error,
            color: Colors.red,
          );
        });
        return false;
      } else {
        password = await data['DOB'];
        if (pword != password) {
          snack.currentState.showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            content: Text('Password is incorrect'),
          ));
          return false;
        } else {
          print('data found');
          await stream();
          return true;
        }
      }
    });
  }

  Future stream() async {
    // ignore: await_only_futures
    await reference
        .collection('student')
        .document(_dept)
        .collection(_batch)
        .document(_regno)
        .snapshots()
        .listen((event) async {
      print('listened');
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
      await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => StudentBottomNav(details)),
      );
    });
    _pass.clear();
    _uname.clear();
    iconType = Icon(Icons.check_circle);

    print('state run successfully');
  }

  Widget validuser() {
    return TextFormField(
      key: ukey,
      maxLength: 12,
      onChanged: (String input) {
        ukey.currentState.validate();
      },
      controller: _uname,
      decoration: InputDecoration(
        filled: true,
        prefixIcon: Icon(Icons.person),
        suffixIcon: iconType,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        labelText: "Username",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontFamily: "Poppins-Medium",
          fontSize: ScreenUtil.getInstance().setSp(26),
        ),
      ),
      onSaved: (String input) {
        initialname = input;
      },
      validator: (String input) {
        if (!RegExp(r"^[0-9]{12}$").hasMatch(input)) {
          setState(() {
            iconType = Icon(
              Icons.error,
              color: Colors.red,
            );
          });
          return 'Invalid Details';
        } else {
          setState(() {
            iconType = Icon(
              Icons.check_circle,
              color: Colors.green,
            );
          });
        }
        return null;
      },
    );
  }

  Widget validpass() {
    return TextFormField(
      key: passkey,
      controller: _pass,
      maxLength: 10,
      onChanged: (String input) {
        passkey.currentState.validate();
      },
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        prefixIcon: Icon(Icons.vpn_key),
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        labelText: "Password",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontFamily: "Poppins-Medium",
          fontSize: ScreenUtil.getInstance().setSp(26),
        ),
      ),
      onSaved: (String input) {
        pword = input;
      },
      validator: (String input) {
        if (!RegExp(r"^[0-9/-]{10}$").hasMatch(input)) {
          return 'Password is incorrect';
        }
        return null;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    iconType = Icon(Icons.check_circle);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      key: snack,
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
                            validuser(),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            validpass(),
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
                                onTap: () async {
                                  if (ukey.currentState.validate()) {
                                    if (passkey.currentState.validate()) {
                                      processdata();
                                    }
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
