import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {

  String name,rollno,regno,phno,dob,batch,email,bloodgrp,department,address,profileurl;
  List ccil;
  Profile(this.ccil);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  @override

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  CircularProfileAvatar(
          widget.ccil[10],
          radius: 100,               
          backgroundColor: Colors.transparent, 
          borderWidth: 10,  
          borderColor: Colors.brown, 
          cacheImage: true, 
          onTap: () {
            print('success');
          }, 
          ),
                Column(
                  children: <Widget>[
                    Text('Name'+widget.ccil[0]),
                    Text('Register No:'+widget.ccil[1]),
                Text('Roll No '+widget.ccil[2]),
                Text('Phone Number '+widget.ccil[3]),
                Text('DOB '+widget.ccil[4]),
                Text('Batch '+widget.ccil[5]),
                Text('Email '+widget.ccil[6]),
                Text('BloodGroup '+widget.ccil[7]),
                Text('Department '+widget.ccil[8]),
                Text('Address '+widget.ccil[9]),
                  ],
                ),
                

              ],
            ),
          ),
        ),
      ),
    );
  }
}
