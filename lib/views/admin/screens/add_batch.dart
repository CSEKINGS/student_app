import 'package:flutter/material.dart';

import '../widgets/designs.dart';

class AddBatch extends StatefulWidget {
  @override
  _AddBatchState createState() => _AddBatchState();
}

class _AddBatchState extends State<AddBatch> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 4 / 3,
          padding: const EdgeInsets.all(8),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: const <Widget>[
            Designs('Add class'),
            Designs('Add year'),
            Designs('Add dep'),
            Designs('Delete students'),
            Designs('Delete class'),
            Designs('Delete department'),
            Designs('Delete year'),
          ],
        ),
      ),
    );
  }
}
