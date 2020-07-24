import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadProfile extends StatefulWidget {
  @override
  _UploadProfile createState() => _UploadProfile();
}

class _UploadProfile extends State<UploadProfile> {
  String id,
      name,
      rollNo,
      regNo,
      email,
      phoneNo,
      blood,
      batch,
      dept,
      address,
      dob;
  File _image;
  String profileUrl;
  final TextEditingController formCont = TextEditingController();
  final TextEditingController formCont1 = TextEditingController();
  final TextEditingController formCont2 = TextEditingController();
  final TextEditingController formCont3 = TextEditingController();
  final TextEditingController formCont4 = TextEditingController();
  final TextEditingController formCont5 = TextEditingController();
  final TextEditingController formCont6 = TextEditingController();
  final TextEditingController formCont7 = TextEditingController();
  final TextEditingController formCont8 = TextEditingController();
  final TextEditingController formCont9 = TextEditingController();
  final TextEditingController formCont10 = TextEditingController();
  final TextEditingController formCont11 = TextEditingController();
  final TextEditingController formCont12 = TextEditingController();
  final TextEditingController formCont13 = TextEditingController();
  final TextEditingController formCont14 = TextEditingController();
  final TextEditingController formCont15 = TextEditingController();
  final picker = ImagePicker();

  Future getImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image.path);
    });
  }

  Future upload(BuildContext context) async {
    if (formkey.currentState.validate()) {
      //      String fileName = basename(_image.path);
      try {
        StorageReference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('profile/$batch/$dept/$rollNo');
        StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
        var url = await taskSnapshot.ref.getDownloadURL();
        profileUrl = url.toString();
        print('$profileUrl');
        DocumentReference ref = Firestore.instance
            .collection('student')
            .document('$dept')
            .collection('$batch')
            .document('$regNo');
        ref.setData({
          'Name': '$name',
          'Rollno': '$rollNo',
          'Regno': '$regNo',
          'Email': '$email',
          'PhoneNo': '$phoneNo',
          'BloodGroup': '$blood',
          'Batch': '$batch',
          'Department': '$dept',
          'Address': '$address',
          'ProfileUrl': '$profileUrl',
          'DOB':'$dob'
        });

        Scaffold.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Profile Picture Uploaded'),
        ));

        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Submitted Successfully'),
        ));
        formCont.clear();
        formCont1.clear();
        formCont2.clear();
        formCont3.clear();
        formCont4.clear();
        formCont5.clear();
        formCont6.clear();
        formCont7.clear();
        formCont8.clear();
        formCont9.clear();
        _image = null;
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Select a profile picture'),
        ));
      }
//      PaintingBinding.instance.imageCache.clear();
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Invalid Details'),
      ));
    }
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Widget buildname() {
    return TextFormField(
      controller: formCont,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
          labelText: 'Name',
          hintText: 'Ex: Ramesh M',
          contentPadding: EdgeInsets.all(15.0),
          filled: true,
          fillColor: Colors.white54),
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
      controller: formCont9,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
          labelText: 'Roll Number',
          hintText: 'Ex: B16cs058',
          contentPadding: EdgeInsets.all(15.0),
          filled: true,
          fillColor: Colors.white54),
      maxLength: 8,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Roll Number Required';
        }
        return null;
      },
      onSaved: (String value) {
        rollNo = value;
      },
    );
  }

  Widget buildregno() {
    return TextFormField(
      controller: formCont8,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
          labelText: 'Register Number',
          hintText: 'Ex: 820617104035',
          contentPadding: EdgeInsets.all(15.0),
          filled: true,
          fillColor: Colors.white54),
      maxLength: 12,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Register Number Required';
        }
        return null;
      },
      onSaved: (String value) {
        regNo = value;
      },
    );
  }

  Widget buildemail() {
    return TextFormField(
      controller: formCont7,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
          labelText: 'Email',
          hintText: 'Ex: example@gmail.com',
          contentPadding: EdgeInsets.all(15.0),
          filled: true,
          fillColor: Colors.white54),
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
      controller: formCont6,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
          labelText: 'Phone Number',
          hintText: 'Ex: 9849342931',
          contentPadding: EdgeInsets.all(15.0),
          filled: true,
          fillColor: Colors.white54),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone Number Required';
        }
        return null;
      },
      onSaved: (String value) {
        phoneNo = value;
      },
    );
  }

  Widget buildblood() {
    return TextFormField(
      controller: formCont5,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
          labelText: 'Blood Group',
          hintText: 'Ex: O Positive',
          contentPadding: EdgeInsets.all(15.0),
          filled: true,
          fillColor: Colors.white54),
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
      controller: formCont4,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
          labelText: 'Batch',
          hintText: 'Ex: 2017',
          contentPadding: EdgeInsets.all(15.0),
          filled: true,
          fillColor: Colors.white54),
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
      controller: formCont3,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
          labelText: 'Department',
          hintText: 'Ex: CSE',
          contentPadding: EdgeInsets.all(15.0),
          filled: true,
          fillColor: Colors.white54),
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
      controller: formCont2,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
          labelText: 'Address',
          hintText: 'Ex: 23,Dubai kuruku santhu, dubai',
          contentPadding: EdgeInsets.all(15.0),
          filled: true,
          fillColor: Colors.white54),
      maxLines: 8,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address Required';
        }
        return null;
      },
      onSaved: (String value) {
        address = value;
      },
    );
  }

  Widget builddob() {
    return TextFormField(
      controller: formCont1,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
          labelText: 'DOB',
          hintText: 'EX: 30-12-1999',
          contentPadding: EdgeInsets.all(15.0),
          filled: true,
          fillColor: Colors.white54),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address Required';
        }
        return null;
      },
      onSaved: (String value) {
        dob = value.toString();
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget Uprofile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              getImage();
            },
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Color(0xff476cfb),
              child: ClipOval(
                child: new SizedBox(
                  width: 137.0,
                  height: 137.0,
                  child: (_image != null)
                      ? Image.file(
                          _image,
                          fit: BoxFit.fill,
                        )
                      : Image.asset(
                          'assets/noimage.png',
                          fit: BoxFit.fill,
                        ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Uprofile(),
                  SizedBox(height: 10),
                  buildname(),
                  SizedBox(height: 10),
                  buildrolno(),
                  SizedBox(height: 10),
                  buildregno(),
                  SizedBox(height: 10),
                  buildphno(),
                  SizedBox(height: 10),
                  builddob(),
                  SizedBox(height: 10),
                  buildbatch(),
                  SizedBox(height: 10),
                  buildemail(),
                  SizedBox(height: 10),
                  buildblood(),
                  SizedBox(height: 10),
                  builddept(),
                  SizedBox(height: 10),
                  buildaddr(),
                  SizedBox(height: 10),
                  OutlineButton(
                    child: Text('Submit',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 16,
                        )),
                    onPressed: () {
                      formkey.currentState.save();
                      upload(context);
                    }, //onPressed
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
