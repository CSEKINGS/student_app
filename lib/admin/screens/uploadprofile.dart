import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadProfile extends StatefulWidget {
  @override
  _UploadProfile createState() => _UploadProfile();
}

class _UploadProfile extends State<UploadProfile> {
  String id;
  String name;
  String rollno;
  String regno;
  String email;
  String phno;
  String blood;
  String batch;
  String dept;
  String addr;

  upload() {
    if (formkey.currentState.validate()) {
      DocumentReference ref = Firestore.instance
          .collection('student')
          .document('$dept')
          .collection('$batch')
          .document('$regno');
      ref.setData({
        'Name': '$name',
        'Rollno': '$rollno',
        'Regno': '$regno',
        'Email': '$email',
        'Phone No.': '$phno',
        'Blood Group': '$blood',
        'Batch': '$batch',
        'Department': '$dept',
        'Address': '$addr'
      });
      setState(() => ref.documentID);
      print(ref.documentID);
      ;
    }
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Widget buildname() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name', hintText: 'Ex: Ramesh M'),
      maxLength: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name required';
        }
        return null;
      },
      onSaved: (String value) {
        name = value;
      },
    );
  }

  Widget buildrolno() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Roll Number', hintText: 'Ex: B16cs058'),
      maxLength: 8,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Roll Number Required';
        }
        return null;
      },
      onSaved: (String value) {
        rollno = value;
      },
    );
  }

  Widget buildregno() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Register Number', hintText: 'Ex: 820617104035'),
      maxLength: 12,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Register Number Required';
        }
        return null;
      },
      onSaved: (String value) {
        regno = value;
      },
    );
  }

  Widget buildemail() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email', hintText: 'Ex: example@gmail.com'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email Required';
        }
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?]")
            .hasMatch(value)) {
          return 'Valid Email Required';
        }
        return null;
      },
      onSaved: (String value) {
        email = value;
      },
    );
  }

  Widget buildphno() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Phone Number', hintText: 'Ex: 9849342931'),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone Number Required';
        }
        return null;
      },
      onSaved: (String value) {
        phno = value;
      },
    );
  }

  Widget buildblood() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Blood Group', hintText: 'Ex: O Positive'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Blood Group Required';
        }
        return null;
      },
      onSaved: (String value) {
        blood = value;
      },
    );
  }

  Widget buildbatch() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Batch', hintText: 'Ex: 2017'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Batch Required';
        }
        return null;
      },
      onSaved: (String value) {
        batch = value;
      },
    );
  }

  Widget builddept() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Department', hintText: 'Ex: CSE'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Department Required';
        }
        return null;
      },
      onSaved: (String value) {
        dept = value;
      },
    );
  }

  Widget buildaddr() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Address', hintText: 'Ex: 23,Dubai kuruku santhu, dubai'),
      maxLines: 8,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address Required';
        }
        return null;
      },
      onSaved: (String value) {
        addr = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Upload'),
      ),
      body: SingleChildScrollView(
        child: new Container(
          margin: EdgeInsets.all(20),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildname(),
                buildrolno(),
                buildregno(),
                buildemail(),
                buildphno(),
                buildblood(),
                buildbatch(),
                builddept(),
                buildaddr(),
                RaisedButton(
                  child: Text('Submit',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16)),
                  onPressed: () {
                    formkey.currentState.save();
                    upload();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
