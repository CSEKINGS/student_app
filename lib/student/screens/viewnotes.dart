import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  List name;
  String path;

  getName() {
    final StorageReference storageRef =
        FirebaseStorage.instance.ref().child('notes');
    storageRef.listAll().then((result) {
      if (mounted) {
        setState(() {
          name = result['items'].keys.toList();
        });
      }
    });
  }

  printUrl(String name) async {
    StorageReference ref = FirebaseStorage.instance.ref().child("notes/$name");
    String furl = (await ref.getDownloadURL()).toString();

    _launchURL() async {
      var url = furl;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return _launchURL();
  }

  @override
  void initState() {
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
              onTap: () {
                printUrl(name[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
