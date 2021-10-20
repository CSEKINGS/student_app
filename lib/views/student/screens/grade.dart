import 'package:flutter/material.dart';

/// grade UI
class Grade extends StatefulWidget {
  /// default
  const Grade(this.details);

  /// get register number and DOB to autofill in web view
  final List? details;

  @override
  _GradeState createState() => _GradeState();
}

class _GradeState extends State<Grade> {
  String url = 'https://coe1.annauniv.edu/home/';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('TODO Grades'),
          ],
        ),
      ),
    );
  }
}
