import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final List<String> details;

  const Profile({required this.details});

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
                CircleAvatar(foregroundImage: NetworkImage(widget.details[10]),radius: 110,backgroundColor: Colors.transparent,),
               
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    profileCardView('Name :  ${widget.details[0]}'),
                    profileCardView(
                        'Roll no : ${widget.details[1].toString().toUpperCase()}'),
                    profileCardView('Register no : ${widget.details[2]}'),
                    profileCardView('Phone number : ${widget.details[3]}'),
                    profileCardView('DOB :  ${widget.details[4]}'),
                    profileCardView('Batch :  ${widget.details[5]}'),
                    profileCardView('Email :  ${widget.details[6]}'),
                    profileCardView('Blood group :  ${widget.details[7]}'),
                    profileCardView('Department :  ${widget.details[8]}'),
                    profileCardView('Address :  ${widget.details[9]}'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card profileCardView(String detailsText) {
    return Card(
      elevation: .8,
      child: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Text(
          detailsText,
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
