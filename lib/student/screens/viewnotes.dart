import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
            color: Colors.green,
            onPressed: () {
              getFirebaseImageFolder();
            },
            child: Text('view')),
      ),
    );
  }
}

void getFirebaseImageFolder() {
  final StorageReference storageRef =
      FirebaseStorage.instance.ref().child('notes/');
  storageRef.listAll().then((result) {
    print("result is $result");
  });
}
