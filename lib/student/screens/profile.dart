import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  List details;
  Profile(this.details);

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
                  widget.details[10],
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
                    Text('Name' + widget.details[0]),
                    Text('Register No:' + widget.details[1]),
                    Text('Roll No ' + widget.details[2]),
                    Text('Phone Number ' + widget.details[3]),
                    Text('DOB ' + widget.details[4]),
                    Text('Batch ' + widget.details[5]),
                    Text('Email ' + widget.details[6]),
                    Text('BloodGroup ' + widget.details[7]),
                    Text('Department ' + widget.details[8]),
                    Text('Address ' + widget.details[9]),
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
