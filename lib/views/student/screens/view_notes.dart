import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:student_app/views/student/screens/notes_viewer.dart';
import 'package:student_app/views/student/screens/photo_viewer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'pdf_api.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  TextEditingController controller = TextEditingController();
  final List<String> _searchResult = [];
  List<Reference> _notesList = [];

  Future<void> retrieveNotes() async {
    var result = await FirebaseStorage.instance.ref().child('notes').listAll();

    setState(() {
      _notesList = result.items.toList();
    });
  }

  Future<void> openURL(String filename) async {
    var furl =
        await FirebaseStorage.instance.ref('notes/$filename').getDownloadURL();

    if (await canLaunch(furl)) {
      await launch(furl);
    } else {
      Error error = ArgumentError('Could not launch $furl');
      throw error;
    }
  }

  Future<void> sendURL(String filename) async {
    var furl =
        await FirebaseStorage.instance.ref('notes/$filename').getDownloadURL();
    if (filename.contains("pdf")) {
      final file = await PDFApi.loadNetwork(furl);
      openPDF(context, file);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => PhotoViewer(url: furl)));
    }
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
  @override
  void initState() {
    super.initState();
    retrieveNotes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                  title: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(fontSize: 18.0),
                      border: InputBorder.none,
                    ),
                    textInputAction: TextInputAction.search,
                    onChanged: onSearchTextChanged,
                    onSubmitted: onSearchTextChanged,
                  ),
                  trailing: controller.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.close,
                          ),
                          onPressed: () {
                            if (controller.text.isNotEmpty) {
                              controller.clear();
                              onSearchTextChanged('');
                            }
                          },
                        )
                      : null,
                ),
              ),
            ),
            Expanded(
              child: _searchResult.isNotEmpty && controller.text.isNotEmpty
                  ? ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.lightBlue,
                                blurRadius: 0.1,
                                offset: Offset(0.0, 0.5),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.all(2.0),
                          child: GestureDetector(
                            onTap: () async {
                              sendURL(_notesList[index].name);
                            },
                            child: Card(
                              child: ListTile(
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.file_download,
                                  ),
                                  onPressed: () {
                                    openURL(_searchResult[index].toString());
                                  },
                                ),
                                leading: const Icon(Icons.note),
                                title: Text(
                                  _searchResult[index],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : _searchResult.isEmpty && controller.text.isNotEmpty
                      ? Center(
                          child: Text(
                            'Notes Not Available',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        )
                      : _notesList.isNotEmpty
                          ? ListView.builder(
                              itemCount: _notesList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    sendURL(_notesList[index].name);
                                  },
                                  child: Card(
                                    child: ListTile(
                                      trailing: IconButton(
                                        icon: const Icon(
                                          Icons.arrow_downward,
                                          color: Colors.green,
                                        ),
                                        onPressed: () {
                                          openURL(_notesList[index]
                                              .name
                                              .toString());
                                        },
                                      ),
                                      leading: const Icon(
                                        Icons.insert_drive_file,
                                        color: Colors.deepOrange,
                                      ),
                                      title: Text(_notesList[index].name),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                'Notes Not Available',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
    }

    for (var notes in _notesList) {
      if (notes.toString().toLowerCase().contains(text.toLowerCase())) {
        _searchResult.add(notes.toString());
      }
    }
    setState(() {});
  }
}
