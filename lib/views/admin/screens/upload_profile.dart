import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:student_app/models.dart';

class UploadProfile extends StatefulWidget {
  @override
  _UploadProfile createState() => _UploadProfile();
}

class _UploadProfile extends State<UploadProfile> {
  String? id,
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
  File? _image;
  String? cls;

  String? profileUrl;
  final picker = ImagePicker();
  final reference = FirebaseFirestore.instance;
  String? dep, yer;
  List<Contents> year = [];
  List<Contents> department = [];
  List<Contents> classes = [];
  TextEditingController dobController = TextEditingController();
  DatabaseReference obj = DatabaseReference();

  @override
  void initState() {
    super.initState();
    var yearRef = obj.getDetailRef('year');
    var depRef = obj.getDetailRef('department');
    yearRef.snapshots().listen((event) {
      if (mounted) {
        setState(() {
          for (var i = 0; i < event.docs.length; i++) {
            year.add(Contents.fromSnapshot(event.docs[i]));
          }
        });
      }
    });
    depRef.snapshots().listen((event) {
      if (mounted) {
        setState(() {
          for (var i = 0; i < event.docs.length; i++) {
            department.add(Contents.fromSnapshot(event.docs[i]));
          }
        });
      }
    });
  }

  Future getImage() async {
    try {
      var image = await picker.pickImage(
          source: ImageSource.gallery, maxWidth: 200.0, maxHeight: 200.0);

      setState(() {
        _image = File(image!.path);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('No image selected. Please select a image.'),
      ));
    }
  }

  Future upload(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        var firebaseStorageRef =
            FirebaseStorage.instance.ref().child('profile/$batch/$dept/$regNo');
        var uploadTask = firebaseStorageRef.putFile(_image!);
        var url = await (await uploadTask).ref.getDownloadURL();

        setState(() {
          profileUrl = url.toString();
          print("Hello World");
          print(url);
          print(profileUrl);
          update();
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Profile Picture Uploaded'),
        ));

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Submitted Successfully'),
        ));
        formKey.currentState!.reset();
        setState(() {
          _image = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Select a profile picture'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid Details'),
      ));
    }
  }

  Future update() async {
    FirebaseFirestore.instance
        .collection('collage')
        .doc('student')
        .collection(dept!)
        .doc(batch)
        .collection(cls!)
        .doc(regNo)
        .set({
      'Name': name.toString(),
      'Rollno': rollNo,
      'Regno': regNo,
      'Email': email,
      'PhoneNo': phoneNo,
      'BloodGroup': blood,
      'Batch': batch,
      'Department': dept,
      'Address': address,
      'ProfileUrl': profileUrl,
      'DOB': dob,
      'Class': cls
    });
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget buildNameField() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        labelText: 'Name',
        hintText: 'Ex: Ramesh M',
        contentPadding: EdgeInsets.all(15.0),
        filled: true,
      ),
      maxLength: 20,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Name required';
        }
        return null;
      },
      onSaved: (String? value) {
        name = value;
      },
    );
  }

  Widget buildRollNoField() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        labelText: 'Roll Number',
        hintText: 'Ex: B16cs058',
        contentPadding: EdgeInsets.all(15.0),
        filled: true,
      ),
      maxLength: 8,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Roll Number Required';
        }
        return null;
      },
      onSaved: (String? value) {
        rollNo = value;
      },
    );
  }

  Widget buildRegNoField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        labelText: 'Register Number',
        hintText: 'Ex: 820617104035',
        contentPadding: EdgeInsets.all(15.0),
        filled: true,
      ),
      maxLength: 12,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Register Number Required';
        }
        return null;
      },
      onSaved: (String? value) {
        regNo = value!;
      },
    );
  }

  Widget buildEmailField() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        labelText: 'Email',
        hintText: 'Ex: example@gmail.com',
        contentPadding: EdgeInsets.all(15.0),
        filled: true,
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Email Required';
        }
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Valid Email Required';
        }
        return null;
      },
      onSaved: (String? value) {
        email = value;
      },
    );
  }

  Widget buildPhoneField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        labelText: 'Phone Number',
        hintText: 'Ex: 9849342931',
        contentPadding: EdgeInsets.all(15.0),
        filled: true,
      ),
      maxLength: 10,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Phone Number Required';
        }
        return null;
      },
      onSaved: (String? value) {
        phoneNo = value;
      },
    );
  }

  Widget buildBloodGroupField() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        labelText: 'Blood Group',
        hintText: 'Ex: O Positive',
        contentPadding: EdgeInsets.all(15.0),
        filled: true,
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Blood Group Required';
        }
        return null;
      },
      onSaved: (String? value) {
        blood = value!.toUpperCase();
      },
    );
  }

  Widget buildBatchDropDown() {
    return DropdownButton(
      hint: const Text('select year'),
      onChanged: (String? name) {
        setState(() {
          batch = name;
        });
      },
      value: batch,
      items: year
          .map((e) => DropdownMenuItem(
                value: e.name,
                child: Text(e.name!),
              ))
          .toList(),
    );
  }

  Widget buildDeptDropDown() {
    return DropdownButton(
      hint: const Text('select department'),
      onChanged: (name) {
        setState(() {
          dept = name.toString();
        });
      },
      value: dept,
      items: department
          .map((e) => DropdownMenuItem(
                value: e.name,
                child: Text(e.name!),
              ))
          .toList(),
    );
  }

  Widget buildAddressField() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        labelText: 'Address',
        hintText: 'Ex: 23,Dubai kuruku santhu, dubai',
        contentPadding: EdgeInsets.all(15.0),
        filled: true,
      ),
      maxLines: 8,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Address Required';
        }
        return null;
      },
      onSaved: (String? value) {
        address = value;
      },
    );
  }

  Widget buildDOBField() {
    DateTime currentDateTime = DateTime.now(),
        initialDateTime = currentDateTime.add(Duration(days: -(10 * 365))),
        firstDateTime = currentDateTime.add(Duration(days: -(60 * 365))),
        lastDateTime = currentDateTime.add(Duration(days: -(5 * 365)));
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: dobController,
      readOnly: true,
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: initialDateTime,
          firstDate: firstDateTime,
          lastDate: lastDateTime,
        ).then((newDateTime) {
          if (newDateTime != null) {
            dobController.text = DateFormat('dd-MM-yyyy').format(newDateTime);
            dob = DateFormat('dd-MM-yyyy').format(newDateTime);
          }
        });
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        labelText: 'DOB',
        hintText: 'EX: 30-12-1999',
        contentPadding: EdgeInsets.all(15.0),
        filled: true,
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Date of Birth Required';
        }
        return null;
      },
    );
  }

  void initiateClass() {
    CollectionReference reference;
    reference = obj.getDetailRef2(batch, dept);
    reference.snapshots().listen((event) {
      classes.clear();
      setState(() {
        for (var i = 0; i < event.docs.length; i++) {
          classes.add(Contents.fromSnapshot(event.docs[i]));
        }
      });
    });
  }

  Widget retrieveClasses(batch, dept) {
    initiateClass();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'CLASS',
          style: TextStyle(),
        ),
        DropdownButton(
          hint: const Text('select class'),
          onChanged: (name) {
            setState(() {
              cls = name.toString();
            });
          },
          value: cls,
          items: classes
              .map((e) => DropdownMenuItem(
                    value: e.name,
                    child: Text(e.name!),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget uploadProfilePic() {
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
              backgroundColor: const Color(0xff476cfb),
              child: ClipOval(
                child: SizedBox(
                  width: 137.0,
                  height: 137.0,
                  child: (_image != null)
                      ? Image.file(
                          _image!,
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
            margin: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  uploadProfilePic(),
                  const SizedBox(height: 10),
                  buildNameField(),
                  const SizedBox(height: 10),
                  buildRollNoField(),
                  const SizedBox(height: 10),
                  buildRegNoField(),
                  const SizedBox(height: 10),
                  buildPhoneField(),
                  const SizedBox(height: 10),
                  buildDOBField(),
                  const SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'BATCH',
                          style: TextStyle(),
                        ),
                        buildBatchDropDown()
                      ]),
                  const SizedBox(height: 10),
                  buildEmailField(),
                  const SizedBox(height: 10),
                  buildBloodGroupField(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'DEPARTMENT',
                        style: TextStyle(),
                      ),
                      Container(child: buildDeptDropDown()),
                    ],
                  ),
                  (dept != null && batch != null)
                      ? retrieveClasses(batch, dept)
                      : Container(),
                  const SizedBox(height: 10),
                  buildAddressField(),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      formKey.currentState!.save();
                      upload(context);
                    },
                    child: const Text('Submit',
                        style: TextStyle(
                          fontSize: 16,
                        )), //onPressed
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
