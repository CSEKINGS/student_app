import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_app/models.dart';

class AddDetails extends StatefulWidget {
  final String? year, dept;

  const AddDetails(this.year, this.dept);

  @override
  _AddDetailsState createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  List<Contents> classes = [];
  TextEditingController eCtrl = TextEditingController();
  String? name;
  DatabaseReference obj = DatabaseReference();

  @override
  void initState() {
    super.initState();
    getClass();
  }

  void getClass() {
    clearData();
    var yer = widget.year;
    var dep = widget.dept;
    late CollectionReference getRef;
    if (yer != null && dep != null) {
      getRef = obj.getDetailRef2(yer, dep);
    } else if (yer == null && dep != null) {
      getRef = obj.getDetailRef(dep);
    } else if (dep == null && yer != null) {
      getRef = obj.getDetailRef(yer);
    }
    getRef.snapshots().listen((event) {
      if (mounted) {
        setState(() {
          for (var i = 0; i < event.docs.length; i++) {
            classes.add(Contents.fromSnapshot(event.docs[i]));
          }
        });
      }
    });
  }

  void clearData() {
    setState(() {
      classes.clear();
    });
  }

  void addClassname(String name) {
    var year = widget.year;
    var dep = widget.dept;
    late CollectionReference addRef;
    if (year != null && dep != null) {
      addRef = obj.getDetailRef2(year, dep);
    } else if (year == null && dep != null) {
      addRef = obj.getDetailRef(dep);
    } else if (dep == null && year != null) {
      addRef = obj.getDetailRef(year);
    }
    addRef.add({
      'name': name.toUpperCase(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add class'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: eCtrl,
              onSubmitted: (text) {
                addClassname(text.toString());
                eCtrl.clear();
                clearData();
                setState(() {});
              },
            ),
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              itemCount: classes.length,
              itemBuilder: (context, int index) => ListTile(
                title: Text(classes[index].name.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
