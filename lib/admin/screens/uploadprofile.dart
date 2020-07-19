import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadProfile extends StatefulWidget {
  @override
  _UploadProfile createState() => _UploadProfile();
}

class _UploadProfile extends State<UploadProfile> {
  String id, name, rollno, regno, email, phno, blood, batch, dept, addr, dobb;
  File _image;
  String profileurl;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }

  Future upload(BuildContext context) async {
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
        'PhoneNo.': '$phno',
        'BloodGroup': '$blood',
        'Batch': '$batch',
        'Department': '$dept',
        'Address': '$addr',
        'ProfileUrl': '$profileurl'
      });
      //      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('profile/$batch/$dept/$rollno');
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      var url = (await taskSnapshot.ref.getDownloadURL());
      profileurl = url.toString();

      setState(() {
        print("Profile Picture uploaded");
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Profile Picture Uploaded'),
        ));
      });

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Submitted Successfully'),
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Invalid Details'),
      ));
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
      keyboardType: TextInputType.phone,
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
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
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
      keyboardType: TextInputType.phone,
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
        blood = value.toUpperCase();
      },
    );
  }

  Widget buildbatch() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(labelText: 'Batch', hintText: 'Ex: 2017'),
      maxLength: 04,
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
        dept = value.toUpperCase();
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

  Widget builddob() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(labelText: 'DOB', hintText: 'EX: 30-12-1999'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address Required';
        }
        return null;
      },
      onSaved: (String value) {
        dobb = value.toString();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                buildphno(),
                builddob(),
                buildbatch(),
                buildemail(),
                buildblood(),
                builddept(),
                buildaddr(),
                RaisedButton(
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.lightGreen,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    getImage();
                  },
                ),
                RaisedButton(
                  child: Text('Submit',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16)),
                  onPressed: () {
                    formkey.currentState.save();
                    upload(context);
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
