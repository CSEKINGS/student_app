import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadNotes extends StatefulWidget {
  UploadNotes() : super();

  final String title = 'Firebase Storage';

  @override
  UploadNotesState createState() => UploadNotesState();
}

class UploadNotesState extends State<UploadNotes> {
  File file;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final List<UploadTask> _tasks = <UploadTask>[];

  void openFileExplorer() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path);
    } else {
      print('no file selected');
    }
    try {
      var fileName = file.toString().split('/').last;
      String filePath = file.toString();
      upload(fileName, filePath);
    } catch (e) {
      print(e);
    }
  }

  void upload(fileName, filePath) async {
    try {
      await FirebaseStorage.instance.ref('notes/$fileName').putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
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
