import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadNotes extends StatefulWidget {
  const UploadNotes() : super();

  final String title = 'Firebase Storage';

  @override
  UploadNotesState createState() => UploadNotesState();
}

class UploadNotesState extends State<UploadNotes> {
  late File _file;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final List<UploadTask> _tasks = <UploadTask>[];

  void _openFileExplorer() async {
    var result = await FilePicker.platform.pickFiles();

    if (result != null) {
      _file = File(result.files.single.path!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file selected'),
        ),
      );
    }
    try {
      var fileName = _file.path.split('/').last;
      var filePath = _file.toString();
      var extension = _file.toString().split('.').last;
      _upload(fileName, filePath, extension);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  void _upload(fileName, filePath, extension) async {
    var metadata = SettableMetadata(
      contentType: '$extension',
    );
    try {
      await FirebaseStorage.instance
          .ref('notes/$fileName')
          .putFile(_file, metadata);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var task in _tasks) {
      final Widget tile = UploadTaskListTile(
        task: task,
      );
      children.add(tile);
    }

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: OutlinedButton(
                  onPressed: _openFileExplorer,
                  child: const Text('Upload notes'),
                ),
              ),
              const SizedBox(
                height: 20.0,
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
    );
  }
}

class UploadTaskListTile extends StatelessWidget {
  final UploadTask? task;

  UploadTaskListTile({Key? key, this.task}) : super(key: key);

  

  String _bytesTransferred(TaskSnapshot snapshot) {
    return '${snapshot.bytesTransferred}/${snapshot.totalBytes}';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
        Widget subtitle;
        if (asyncSnapshot.hasData) {
          final snapshot = task!.snapshot;
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
