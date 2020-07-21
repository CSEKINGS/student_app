////import 'package:flutter/material.dart';
////import 'package:flutter/services.dart';
////
////class Example extends StatefulWidget {
////  @override
////  _TextEditingControllerExampleState createState() {
////    return _TextEditingControllerExampleState();
////  }
////}
////
////class _TextEditingControllerExampleState extends State<Example> {
////  final _myController = TextEditingController(text: 'Woolha');
////
////  TextSpan _myTextSpan = TextSpan();
////  @override
////  void dispose() {
////    _myController.dispose();
////
////    super.dispose();
////  }
////
////  @override
////  Widget build(BuildContext context) {
////    print("build");
////    return Scaffold(
////      body: Padding(
////          padding: const EdgeInsets.all(16.0),
////          child: Column(
////            children: <Widget>[
////              Form(
////                child: Column(
////                  crossAxisAlignment: CrossAxisAlignment.start,
////                  children: <Widget>[
////                    TextFormField(
////                      key: Key('name'),
////                      controller: _myController,
////                      decoration: InputDecoration(labelText: 'Name'),
////                    ),
////                    Wrap(
////                      spacing: 20,
////                      children: <Widget>[
////                        RaisedButton(
////                          onPressed: () {
////                            return showDialog(
////                              context: context,
////                              builder: (context) {
////                                return AlertDialog(
////                                  content: Text(
////                                      '${_myController.text}\n${_myController.selection.toString()}'),
////                                );
////                              },
////                            );
////                          },
////                          child: Text('Show'),
////                        ),
////                        RaisedButton(
////                          onPressed: () {
////                            String newText = 'Woolha.com';
////
////                            _myController.text = newText;
////
////                            _myController.selection =
////                                TextSelection.collapsed(offset: newText.length);
////                          },
////                          child: Text('Set Text'),
////                        ),
////                        RaisedButton(
////                          onPressed: () {
////                            _myController.clear();
////                          },
////                          child: Text('Clear'),
////                        ),
////                        RaisedButton(
////                          onPressed: () {
////                            setState(() {
////                              _myTextSpan = _myController.buildTextSpan(
////                                  style: TextStyle(color: Colors.red),
////                                  withComposing: false);
////                            });
////                          },
////                          child: Text('Build TextSpan'),
////                        ),
////                      ],
////                    )
////                  ],
////                ),
////              ),
////              RichText(
////                text: _myTextSpan,
////              )
////            ],
////          )),
////    );
////  }
////}
////
//import 'dart:io';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
//
//class UploadProfile extends StatefulWidget {
//  @override
//  _UploadProfile createState() => _UploadProfile();
//}
//
//class _UploadProfile extends State<UploadProfile> {
//  String id, name, rollno, regno, email, phno, blood, batch, dept, addr, dobb;
//  File _image;
//  String profileurl;
////  final TextEditingController formcont = TextEditingController();
////  final TextEditingController formcont1 = TextEditingController();
////  final TextEditingController formcont2 = TextEditingController();
////  final TextEditingController formcont3 = TextEditingController();
////  final TextEditingController formcont4 = TextEditingController();
////  final TextEditingController formcont5 = TextEditingController();
////  final TextEditingController formcont6 = TextEditingController();
////  final TextEditingController formcont7 = TextEditingController();
////  final TextEditingController formcont8 = TextEditingController();
////  final TextEditingController formcont9 = TextEditingController();
////  final TextEditingController formcont10 = TextEditingController();
////  final TextEditingController formcont11 = TextEditingController();
////  final TextEditingController formcont12 = TextEditingController();
////  final TextEditingController formcont13 = TextEditingController();
////  final TextEditingController formcont14 = TextEditingController();
////  final TextEditingController formcont15 = TextEditingController();
//  Future getImage() async {
//    var image = await ImagePicker().getImage(source: ImageSource.gallery);
//
//    setState(() {
//      final _image = image;
//      print('Image Path $_image');
//    });
//  }
//
//  Future upload(BuildContext context) async {
//    if (formkey.currentState.validate()) {
//      DocumentReference ref = Firestore.instance
//          .collection('student')
//          .document('$dept')
//          .collection('$batch')
//          .document('$regno');
//      ref.setData({
//        'Name': '$name',
//        'Rollno': '$rollno',
//        'Regno': '$regno',
//        'Email': '$email',
//        'PhoneNo.': '$phno',
//        'BloodGroup': '$blood',
//        'Batch': '$batch',
//        'Department': '$dept',
//        'Address': '$addr',
//        'ProfileUrl': '$profileurl',
//        'DOB': '$dobb'
//      });
//      //      String fileName = basename(_image.path);
//      StorageReference firebaseStorageRef =
//      FirebaseStorage.instance.ref().child('profile/$batch/$dept/$rollno');
//      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
//      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//      var url = (await taskSnapshot.ref.getDownloadURL());
//      profileurl = url.toString();
//
//      setState(() {
//        print("Profile Picture uploaded");
//        Scaffold.of(context).showSnackBar(SnackBar(
//          content: Text('Profile Picture Uploaded'),
//        ));
//      });
//
//      Scaffold.of(context).showSnackBar(SnackBar(
//        content: Text('Submitted Successfully'),
//      ));
////      formcont.clear();
////      formcont1.clear();
////      formcont2.clear();
////      formcont3.clear();
////      formcont4.clear();
////      formcont5.clear();
////      formcont6.clear();
////      formcont7.clear();
////      formcont8.clear();
////      formcont9.clear();
//    } else {
//      Scaffold.of(context).showSnackBar(SnackBar(
//        content: Text('Invalid Details'),
//      ));
//    }
//  }
//
//  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
//  Widget buildname() {
//    return TextFormField(
//      decoration: InputDecoration(
//          border: OutlineInputBorder(
//              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
//          labelText: 'Name',
//          hintText: 'Ex: Ramesh M',
//          contentPadding: EdgeInsets.all(15.0),
//          filled: true,
//          fillColor: Colors.white54),
//      maxLength: 20,
//      validator: (String value) {
//        if (value.isEmpty) {
//          return 'Name required';
//        }
//        return null;
//      },
//      onSaved: (String value) {
//        name = value;
//      },
////      controller: formcont,
//    );
//  }
//
//  Widget buildrolno() {
//    return TextFormField(
////      controller: formcont1,
//      decoration: InputDecoration(
//          border: OutlineInputBorder(
//              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
//          labelText: 'Roll Number',
//          hintText: 'Ex: B16cs058',
//          contentPadding: EdgeInsets.all(15.0),
//          filled: true,
//          fillColor: Colors.white54),
//      maxLength: 8,
//      validator: (String value) {
//        if (value.isEmpty) {
//          return 'Roll Number Required';
//        }
//        return null;
//      },
//      onSaved: (String value) {
//        rollno = value;
//      },
//    );
//  }
//
//  Widget buildregno() {
//    return TextFormField(
////      controller: formcont2,
//      keyboardType: TextInputType.phone,
//      decoration: InputDecoration(
//          border: OutlineInputBorder(
//              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
//          labelText: 'Register Number',
//          hintText: 'Ex: 820617104035',
//          contentPadding: EdgeInsets.all(15.0),
//          filled: true,
//          fillColor: Colors.white54),
//      maxLength: 12,
//      validator: (String value) {
//        if (value.isEmpty) {
//          return 'Register Number Required';
//        }
//        return null;
//      },
//      onSaved: (String value) {
//        regno = value;
//      },
//    );
//  }
//
//  Widget buildemail() {
//    return TextFormField(
////      controller: formcont3,
//      decoration: InputDecoration(
//          border: OutlineInputBorder(
//              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
//          labelText: 'Email',
//          hintText: 'Ex: example@gmail.com',
//          contentPadding: EdgeInsets.all(15.0),
//          filled: true,
//          fillColor: Colors.white54),
//      validator: (String value) {
//        if (value.isEmpty) {
//          return 'Email Required';
//        }
//        if (!RegExp(
//            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
//            .hasMatch(value)) {
//          return 'Valid Email Required';
//        }
//        return null;
//      },
//      onSaved: (String value) {
//        email = value;
//      },
//    );
//  }
//
//  Widget buildphno() {
//    return TextFormField(
////      controller: formcont4,
//      keyboardType: TextInputType.phone,
//      decoration: InputDecoration(
//          border: OutlineInputBorder(
//              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
//          labelText: 'Phone Number',
//          hintText: 'Ex: 9849342931',
//          contentPadding: EdgeInsets.all(15.0),
//          filled: true,
//          fillColor: Colors.white54),
//      maxLength: 10,
//      validator: (String value) {
//        if (value.isEmpty) {
//          return 'Phone Number Required';
//        }
//        return null;
//      },
//      onSaved: (String value) {
//        phno = value;
//      },
//    );
//  }
//
//  Widget buildblood() {
//    return TextFormField(
////      controller: formcont5,
//      decoration: InputDecoration(
//          border: OutlineInputBorder(
//              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
//          labelText: 'Blood Group',
//          hintText: 'Ex: O Positive',
//          contentPadding: EdgeInsets.all(15.0),
//          filled: true,
//          fillColor: Colors.white54),
//      validator: (String value) {
//        if (value.isEmpty) {
//          return 'Blood Group Required';
//        }
//        return null;
//      },
//      onSaved: (String value) {
//        blood = value.toUpperCase();
//      },
//    );
//  }
//
//  Widget buildbatch() {
//    return TextFormField(
////      controller: formcont6,
//      keyboardType: TextInputType.phone,
//      decoration: InputDecoration(
//          border: OutlineInputBorder(
//              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
//          labelText: 'Batch',
//          hintText: 'Ex: 2017',
//          contentPadding: EdgeInsets.all(15.0),
//          filled: true,
//          fillColor: Colors.white54),
//      maxLength: 04,
//      validator: (String value) {
//        if (value.isEmpty) {
//          return 'Batch Required';
//        }
//        return null;
//      },
//      onSaved: (String value) {
//        batch = value;
//      },
//    );
//  }
//
//  Widget builddept() {
//    return TextFormField(
////      controller: formcont7,
//      decoration: InputDecoration(
//          border: OutlineInputBorder(
//              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
//          labelText: 'Department',
//          hintText: 'Ex: CSE',
//          contentPadding: EdgeInsets.all(15.0),
//          filled: true,
//          fillColor: Colors.white54),
//      validator: (String value) {
//        if (value.isEmpty) {
//          return 'Department Required';
//        }
//        return null;
//      },
//      onSaved: (String value) {
//        dept = value.toUpperCase();
//      },
//    );
//  }
//
//  Widget buildaddr() {
//    return TextFormField(
////      controller: formcont8,
//      decoration: InputDecoration(
//          border: OutlineInputBorder(
//              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
//          labelText: 'Address',
//          hintText: 'Ex: 23,Dubai kuruku santhu, dubai',
//          contentPadding: EdgeInsets.all(15.0),
//          filled: true,
//          fillColor: Colors.white54),
//      maxLines: 8,
//      validator: (String value) {
//        if (value.isEmpty) {
//          return 'Address Required';
//        }
//        return null;
//      },
//      onSaved: (String value) {
//        addr = value;
//      },
//    );
//  }
//
//  Widget builddob() {
//    return TextFormField(
////      controller: formcont9,
//      keyboardType: TextInputType.phone,
//      decoration: InputDecoration(
//          border: OutlineInputBorder(
//              borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
//          labelText: 'DOB',
//          hintText: 'EX: 30-12-1999',
//          contentPadding: EdgeInsets.all(15.0),
//          filled: true,
//          fillColor: Colors.white54),
//      validator: (String value) {
//        if (value.isEmpty) {
//          return 'Address Required';
//        }
//        return null;
//      },
//      onSaved: (String value) {
//        dobb = value.toString();
//      },
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return SafeArea(
//      child: Scaffold(
//        body: SingleChildScrollView(
//          child: Container(
//            margin: EdgeInsets.all(20),
//            child: Form(
//              key: formkey,
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  buildname(),
//                  SizedBox(height: 10),
//                  buildrolno(),
//                  SizedBox(height: 10),
//                  buildregno(),
//                  SizedBox(height: 10),
//                  buildphno(),
//                  SizedBox(height: 10),
//                  builddob(),
//                  SizedBox(height: 10),
//                  buildbatch(),
//                  SizedBox(height: 10),
//                  buildemail(),
//                  SizedBox(height: 10),
//                  buildblood(),
//                  SizedBox(height: 10),
//                  builddept(),
//                  SizedBox(height: 10),
//                  buildaddr(),
//                  SizedBox(height: 10),
//                  OutlineButton(
//                    child: Text(
//                      'Profile',
//                      style: TextStyle(color: Colors.lightGreen, fontSize: 16),
//                      textAlign: TextAlign.center,
//                    ),
//                    onPressed: () {
//                      getImage();
//                    },
//                  ),
//                  OutlineButton(
//                    child: Text('Submit',
//                        style:
//                        TextStyle(color: Colors.blueAccent, fontSize: 16)),
//                    onPressed: () {
//                      formkey.currentState.save();
//                      upload(context);
//                    },
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
