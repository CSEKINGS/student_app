import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/designs.dart';

class MarkEntry extends StatefulWidget {
  @override
  _MarkEntryState createState() => _MarkEntryState();
}

class _MarkEntryState extends State<MarkEntry> {
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
          children: <Widget>[
            const Designs('Add class'),
            const Designs('Add year'),
            const Designs('Add dep'),
            const Designs('Delete students'),
            const Designs('Delete class'),
            const Designs('Delete department'),
            const Designs('Delete year'),
            OutlinedButton(
                onPressed: () async {
                  final _auth = FirebaseAuth.instance;
                  await _auth.signOut();
                  Navigator.of(context).pop(false);
                },
                child: const Text('Sign out'))
          ],
        ),
      ),
    );
  }
}
