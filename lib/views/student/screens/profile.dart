import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final List<String>? details;

  const Profile(this.details);

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
                  widget.details?[10] ??
                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                  radius: 110,
                  backgroundColor: Colors.transparent,
                  borderWidth: 10,
                  cacheImage: true,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    profileCardView(
                        'Name :  ${widget.details?[0] ?? "Unknown"}'),
                    profileCardView(
                        'Roll no : ${widget.details?[1].toString().toUpperCase() ?? "Unknown"}'),
                    profileCardView(
                        'Register no : ${widget.details?[2] ?? "Unknown"}'),
                    profileCardView(
                        'Phone number : ${widget.details?[3] ?? "Unknown"}'),
                    profileCardView(
                        'DOB :  ${widget.details?[4] ?? "Unknown"}'),
                    profileCardView(
                        'Batch :  ${widget.details?[5] ?? "Unknown"}'),
                    profileCardView(
                        'Email :  ${widget.details?[6] ?? "Unknown"}'),
                    profileCardView(
                        'Blood group :  ${widget.details?[7] ?? "Unknown"}'),
                    profileCardView(
                        'Department :  ${widget.details?[8] ?? "Unknown"}'),
                    profileCardView(
                        'Address :  ${widget.details?[9] ?? "Unknown"}'),
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
