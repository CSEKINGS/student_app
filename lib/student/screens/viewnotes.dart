import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  List name;

  void getName() {
    final StorageReference storageRef =
        FirebaseStorage.instance.ref().child('notes');
    storageRef.listAll().then((result) {
      setState(() {
        name = result['items'].keys.toList();
      });
    });
  }

  printUrl() async {
    StorageReference ref =
        FirebaseStorage.instance.ref().child("notes/sample.pdf");
    String url = (await ref.getDownloadURL()).toString();
    print(url);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: name == null ? 0 : name.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              trailing: Icon(Icons.file_download),
              leading: Icon(Icons.picture_as_pdf),
              title: Text(name[index]),
            ),
          );
        },
      ),
    );
  }
}
