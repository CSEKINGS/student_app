import 'package:flutter/material.dart';

/// grade UI
class Grade extends StatefulWidget {
  /// default
  const Grade();

  @override
  _GradeState createState() => _GradeState();
}

class _GradeState extends State<Grade> {
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
