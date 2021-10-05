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
  String file_name = "";
  bool uploading = false;

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
      setState(() {
        file_name = fileName;
      });
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
    setState(() {
      uploading = true;
    });
    var metadata = SettableMetadata(
      contentType: '$extension',
    );
    try {
      await FirebaseStorage.instance
          .ref('notes/$fileName')
          .putFile(_file, metadata)
          .whenComplete(() {
        setState(() {
          uploading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Note Uploaded Successfully"),
        ));
      });
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
                height: 40.0,
              ),
              Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        uploading
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, right: 4),
                                child: LinearProgressIndicator(),
                              )
                            : SizedBox(),
                        Spacer(),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  file_name == ""
                                      ? "No Notes Selected"
                                      : file_name,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              file_name == ""
                                  ? SizedBox()
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: CircleAvatar(
                                        backgroundColor: uploading
                                            ? Colors.white
                                            : Colors.green,
                                        radius: 5,
                                      ),
                                    )
                            ],
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(5))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            file_name = "";
                          });
                        },
                        child: Text(
                          "clear",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Flexible(
              //   child: ListView(
              //     children: children,
              //   ),
              // ),
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
          subtitle = Text(' ${_bytesTransferred(snapshot)} bytes sent',
              style: TextStyle(
                color: Colors.white,
              ));
        } else {
          subtitle = const Text(
            'Starting...',
            style: TextStyle(color: Colors.white),
          );
        }
        return ListTile(
          title: Text(
            'Upload Task #${task.hashCode}',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: subtitle,
        );
      },
    );
  }
}
