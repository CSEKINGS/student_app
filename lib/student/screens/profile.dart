import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {

  String name,rollno,regno,phno,dob,batch,email,bloodgrp,department,address,profileurl;
  Profile(this.name,this.rollno,this.regno,this.phno,this.dob,this.batch,this.email,this.bloodgrp,this.department,this.address,this.profileurl);

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
          widget.profileurl,
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
                    Text('Name'+widget.name),
                    Text('Register No:'+widget.regno),
                Text('Roll No '+widget.rollno),
                Text('Phone Number '+widget.phno),
                Text('DOB '+widget.dob),
                Text('Batch '+widget.batch),
                Text('Email '+widget.email),
                Text('BloodGroup '+widget.bloodgrp),
                Text('Department '+widget.department),
                Text('Address '+widget.address),
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
