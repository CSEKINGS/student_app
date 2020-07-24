import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_app/admin/widgets/adminbottomnavbar.dart';
import 'package:student_app/student/widgets/studentbottomnavbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
//   static _LoginPageState sd = new _LoginPageState();
//  String cc = sd._college;
//  String dd=sd._dept;
//  String bb=sd._batch;
//  String rr=sd._rollno;

}

class _LoginPageState extends State<LoginPage> {
  String _college, _dept, _batch, _rollno;
  String gg;
  String uname;
//  var userdocument=Firestore.instance.collection().document().collection().document().snapshot().data
//  var info = new List();
//  List<String> info = [];
  // var c, d, b, r;
  // ignore: non_constant_identifier_names
  final TextEditingController Euname = TextEditingController();
  final GlobalKey<FormState> logkey = GlobalKey<FormState>();
  // ignore: missing_return
  Future studentnavigate(BuildContext context) {
    // var info = <String>{};
    uname =Euname.text;
    // _college=(uname/10000000).truncate();
   _college = uname.substring(0, 4);
   _batch = uname.substring(4, 6);
   _dept = uname.substring(6, 9);
   _rollno = uname.substring(9, 12);
   print('college $_college');
   print('batch $_batch');
   print('dept $_dept');
   print('rollno $_rollno');
if (_batch!=null) {
  _batch='20'+_batch;
}
if(_dept=='101'){
        _dept='AE';
      }
      if(_dept=='103'){
        _dept='CIVIL';
      }
   if(_dept=='104'){
        _dept='CSE';
      }
       if (_dept=='105') {
        _dept='EEE';
        
      if (_dept=='106') {
        _dept='ECE';
        
      }  
     if (_dept=='107') {
        _dept='EIE';
        
      }
      }
         if(_dept=='114'){
        _dept='MECH';
      }
      if (_dept=='205') {
        _dept='IT';
        
      }   
      if (_dept=='121') {
        _dept='BIOMEDICAL';
        
      }   if(_dept=='214'){
        _dept='BIOTECH';
      }
      switch (_dept) {
        case '101':{
          // _dept=
        }
          break;
          case '102':{

          }
          break;
          case '103':{}
          break;
          case '104':{}
          break;
          case '105':{}
          break;
          case '106':{}
          break;
          case '107':{}
          break;
          case '112':{}
          break;
          case '113':{}
          break;
          case '114':{}
          break;
          case '120':{}
          break;
          case '121':{}
          break;
          case '184':{}
          break;
          case '185':{}
          break;
          case '203':{}
          break;
          case '205':{}
          break;
          case '212':{}
          break;
          case '214':{}
          break;
          case '216':{}
          break;
          case '219':{}
          break;
          case '220':{}
          break;

        default:{print('Invalid Department');}
      }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => StudentBottomNav(_college,_batch,_dept,_rollno)),
    );
  }
//

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
//    height: ScreenUtil.getInstance().setHeight(500),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Login",
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(45),
                                  fontFamily: "Poppins-Bold",
                                  letterSpacing: .6)),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          Text("Username",
                              style: TextStyle(
                                  fontFamily: "Poppins-Medium",
                                  fontSize:
                                      ScreenUtil.getInstance().setSp(26))),
                          TextFormField(
                            controller: Euname,
                            decoration: InputDecoration(
                                hintText: "username",
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 12.0)),
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          Text("PassWord",
                              style: TextStyle(
                                  fontFamily: "Poppins-Medium",
                                  fontSize:
                                      ScreenUtil.getInstance().setSp(26))),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 12.0)),
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(35),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(28)),
                              )
                            ],
                          )
                        ],
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
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  studentnavigate(context);
                                  // print(c);
                                  // print(b);
                                  // print(d);
                                  // print(r);
                                  print('$uname');
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
