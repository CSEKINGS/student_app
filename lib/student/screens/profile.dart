import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:student_app/common/login.dart';

class Profile extends StatefulWidget {
//  static LoginPage log = new LoginPage();
//  String cc=log.cc;
//  String bb=log.bb;
//  String dd=log.dd;
//  String rr=log.rr;
//  Profile(this.cc,this.bb,this.dd,this.rr);
 String _college;
  String _batch;
  String _dept;
  String _rollno;
  Profile(this._college,this._batch,this._dept,this._rollno);


  @override
  _ProfileState createState() => _ProfileState(_college,_batch,_dept,_rollno);
}

class _ProfileState extends State<Profile> {
   String _college;
  String _batch;
  String _dept;
  String _rollno;
   _ProfileState(this._college,this._batch,this._dept,this._rollno);
    deptvali (){
      if(_dept=='104'){
        _dept='CSE';
      }
      if (_dept=='106') {
        _dept='ECE';
        
      }
        if(_dept=='103'){
        _dept='CIVIL';
      }
      if (_dept=='105') {
        _dept='EEE';
        
      }
         if(_dept=='114'){
        _dept='MECH';
      }
      if (_dept=='205') {
        _dept='IT';
        
      }   if(_dept=='101'){
        _dept='AE';
      }
      if (_dept=='121') {
        _dept='BIOMEDICAL';
        
      }   if(_dept=='214'){
        _dept='BIOTECH';
      }
      if (_dept=='107') {
        _dept='EIE';
        
      }
   }
  @override

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              deptvali(),
                         StreamBuilder(
                  stream: Firestore.instance
                      .collection('student')
                      .document('${widget._dept}')
                      .collection('20'+'${widget._batch}')
                      .document('8206'+'${widget._batch}'+'${widget._dept}'+'${widget._rollno}')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                       print('8206'+'${widget._batch}'+'${widget._dept}'+'${widget._rollno}');
                      return new Text("Loading");
                     
                    }
                    var userDocument = snapshot.data;
                    return Container(
                         child: Column(
                        children: <Widget>[
                             Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Color(0xff476cfb),
                  child: ClipOval(
                      child: new SizedBox(
                        width: 137.0,
                        height: 137.0,
                        child: (userDocument['ProfileUrl'] != null)
                            ? Image.network(
                                "${userDocument['ProfileUrl']}",
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                'assets/noimage.png',
                                fit: BoxFit.fill,
                              ),
                      ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
                          Text('Name :'+'${userDocument['Name']}'),
                          Text('Rollno :'+'${userDocument['Rollno']}'),
                          Text('Regno :'+'${userDocument['Regno']}'),
                          Text('Email :'+'${userDocument['Email']}'),
                          Text('Phno :'+ '${userDocument['PhoneNo']}'),
                          Text('Blood Group :'+'${userDocument['BloodGroup']}'),
                          Text('Batch :'+'${userDocument['Batch']}'),
                          Text('Department :'+'${userDocument['Department']}'),
                          Text('Address :'+'${userDocument['Address']}'),
                          
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
