import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UploadNotes extends StatefulWidget {
  UploadNotes() : super();

  final String title = 'Firebase Storage';

  @override
  UploadNotesState createState() => UploadNotesState();
}

class UploadNotesState extends State<UploadNotes> {
  final databaseReference = FirebaseFirestore.instance;
  FilePickerResult _path;
  var _paths;
  String _extension;
  final FileType _pickType = FileType.any;
  bool _multiPick = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final List<UploadTask> _tasks = <UploadTask>[];

  void openFileExplorer() async {
    try {
      _path = null;
      if (_multiPick) {
        _paths = (await FilePicker.platform
            .pickFiles(type: _pickType, allowMultiple: true));
      } else {
        _path = (await FilePicker.platform.pickFiles(type: _pickType));
      }
      uploadToFirebase();
    } on PlatformException catch (e) {
      print('Unsupported operation' + e.toString());
    }
    if (!mounted) return;
  }

  void uploadToFirebase() {
    try {
      if (_multiPick) {
        _paths.forEach((fileName, filePath) => {upload(fileName, filePath)});
      } else {
        var fileName = _path.toString().split('/').last;

        var filePath = _path.toString();
        upload(fileName, filePath);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('No file selected, Please select a file to upload.'),
        ),
      );
    }
  }

  void upload(fileName, filePath) {
    _extension = fileName.toString().split('.').last;
    var storageRef = FirebaseStorage.instance.ref().child('notes/$fileName');

    final uploadTask = storageRef.putFile(
      File(filePath),
      SettableMetadata(
        contentType: '$_pickType/$_extension',
      ),
    );
    setState(() {
      _tasks.add(uploadTask);
    });
  }

  void sign0utStaff() async {
    final _auth = FirebaseAuth.instance;
    await _auth.signOut();
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    _tasks.forEach((UploadTask task) {
      final Widget tile = UploadTaskListTile(
        task: task,
      );
      children.add(tile);
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SwitchListTile.adaptive(
                  title: Text('Pick multiple files', textAlign: TextAlign.left),
                  onChanged: (bool value) => setState(() => _multiPick = value),
                  value: _multiPick,
                ),
                Center(
                  child: OutlinedButton(
                    onPressed: () => openFileExplorer(),
                    child: Text('Upload notes'),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Divider(
                  thickness: 1.0,
                ),
                OutlinedButton(
                  onPressed: () => sign0utStaff(),
                  child: Text('Sign Out'),
                ),
                Flexible(
                  child: ListView(
                    children: children,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UploadTaskListTile extends StatelessWidget {
  UploadTaskListTile({Key key, this.task}) : super(key: key);

  // final UploadTask task;
  UploadTask task = FirebaseStorage.instance as UploadTask;

  String _bytesTransferred(TaskSnapshot snapshot) {
    return '${snapshot.bytesTransferred}/${snapshot.totalBytes}';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
        Widget subtitle;
        if (asyncSnapshot.hasData) {
          final snapshot = task.snapshot;
          subtitle = Text(' ${_bytesTransferred(snapshot)} bytes sent');
        } else {
          subtitle = const Text('Starting...');
        }
        return ListTile(
          title: Text('Upload Task #${task.hashCode}'),
          subtitle: subtitle,
        );
      },
    );
  }
}
