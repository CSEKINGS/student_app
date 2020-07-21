import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  TextEditingController controller = TextEditingController();
  List _searchResult = [];
  List _notesList = [];
  String path;

  getNotes() {
    final StorageReference storageRef =
        FirebaseStorage.instance.ref().child('notes');
    storageRef.listAll().then((result) {
      if (mounted) {
        setState(() {
          _notesList = result['items'].keys.toList();
        });
      }
    });
  }

  openURL(String name) async {
    StorageReference ref = FirebaseStorage.instance.ref().child("notes/$name");
    String furl = (await ref.getDownloadURL()).toString();

    _launchURL() async {
      String url = furl;
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
    getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  elevation: 3.0,
                  child: ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                    title: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(fontSize: 18.0),
                        border: InputBorder.none,
                      ),
                      onChanged: onSearchTextChanged,
                    ),
                    trailing: IconButton(
                      icon: Icon(
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
            ),
            Expanded(
              child: _searchResult.length != 0 || controller.text.isNotEmpty
                  ? ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Card(
                            elevation: 5.0,
                            child: ListTile(
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.file_download,
                                ),
                                onPressed: () {
                                  openURL(_searchResult[index]);
                                },
                              ),
                              leading: Icon(Icons.note),
                              title: Text(
                                _searchResult[index],
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.lightBlue,
                                blurRadius: 0.1,
                                offset: Offset(0.0, 0.5),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                itemCount: _notesList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5.0,
                    child: ListTile(
                      trailing: IconButton(
                        icon: Icon(
                          Icons.file_download,
                        ),
                        onPressed: () {
                          openURL(_notesList[index]);
                              },
                            ),
                            leading: Icon(Icons.note),
                            title: Text(
                              _notesList[index],
                            ),
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

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _notesList.forEach((movieDetail) {
      if (movieDetail.toString().toLowerCase().contains(text.toLowerCase()))
        _searchResult.add(movieDetail);
    });

    setState(() {});
  }
}
