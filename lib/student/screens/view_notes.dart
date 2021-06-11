import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  TextEditingController controller = TextEditingController();
  final List _searchResult = [];
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
      throw 'Could not launch $furl';
    }
  }

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
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.close,
                    ),
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: _searchResult.isNotEmpty || controller.text.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
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
                          child: Card(
                            child: ListTile(
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.file_download,
                                ),
                                onPressed: () {
                                  openURL(_searchResult[index].name.toString());
                                },
                              ),
                              leading: const Icon(Icons.note),
                              title: Text(
                                _searchResult[index],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _notesList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.arrow_downward,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                openURL(_notesList[index].name.toString());
                              },
                            ),
                            leading: const Icon(
                              Icons.insert_drive_file,
                              color: Colors.deepOrange,
                            ),
                            title: Text(_notesList[index].name),
                          ),
                        );
                      },
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
      return;
    }

    _notesList.forEach((notes) {
      if (notes.toString().toLowerCase().contains(text.toLowerCase())) {
        _searchResult.add(notes);
      }
    });

    setState(() {});
  }
}
