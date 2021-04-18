import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_app/admin/Models/db_model.dart';

class AddDetails extends StatefulWidget {
  final String yer, dep;

  AddDetails(this.yer, this.dep);

  @override
  _AddDetailsState createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  List<Contents> classes = [];
  TextEditingController eCtrl = TextEditingController();
  String name;
  DatabaseReference obj = DatabaseReference();

  @override
  void initState() {
    super.initState();
    getClass();
  }

  void getClass() {
    clearData();
    var yer = widget.yer;
    var dep = widget.dep;
    CollectionReference getRef;
    if (yer != null && dep != null) {
      getRef = obj.getDetailRef2(yer, dep);
    } else if (yer == null && dep != null) {
      getRef = obj.getDetailRef(dep);
    } else if (dep == null && yer != null) {
      getRef = obj.getDetailRef(yer);
    }
    getRef.snapshots().listen((event) {
      setState(() {
        for (var i = 0; i < event.docs.length; i++) {
          classes.add(Contents.fromSnapshot(event.docs[i]));
        }
      });
    });
  }

  void clearData() {
    setState(() {
      classes.clear();
    });
  }

  void addClassname(String name) {
    var yer = widget.yer;
    var dep = widget.dep;
    CollectionReference addRef;
    if (yer != null && dep != null) {
      addRef = obj.getDetailRef2(yer, dep);
    } else if (yer == null && dep != null) {
      addRef = obj.getDetailRef(dep);
    } else if (dep == null && yer != null) {
      addRef = obj.getDetailRef(yer);
    }
    addRef.add({
      'name': name.toUpperCase(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add class'),
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
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              itemCount: classes.length,
              itemBuilder: (context, int index) => Container(
                child: ListTile(
                  title: Text(classes[index].name.toString()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
