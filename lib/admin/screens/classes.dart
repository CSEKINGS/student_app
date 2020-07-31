// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:student_app/admin/attendance/DbAndRefs.dart';
// import 'package:student_app/admin/screens/upload_profile.dart';

// class classes extends StatefulWidget {
//   String batch, dept;
//   classes(this.batch, this.dept);
//   @override
//   _classesState createState() => _classesState();
// }

// class _classesState extends State<classes> {
//   String cls;
//   List<Contents> classes = List();
//   Dbref obj = new Dbref();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     CollectionReference reference;
//     reference = obj.getDetailRef2(widget.batch, widget.dept);
//     reference.snapshots().listen((event) {
//       setState(() {
//         for (int i = 0; i < event.documents.length; i++) {
//           classes.add(Contents.fromSnapshot(event.documents[i]));
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//           child: Text(
//             'CLASS',
//             style: TextStyle(
//               color: Colors.black87,
//             ),
//           ),
//         ),
//         Container(
//           child: DropdownButton(
//             hint: Text('select class'),
//             onChanged: (name) {
//               setState(() {
//                 cls = name;
//                 if (cls != null) {
//                   getclass(this.cls);
//                 }
//               });
//             },
//             value: cls,
//             items: classes
//                 .map((e) => DropdownMenuItem(
//                       child: Text(e.name),
//                       value: e.name,
//                     ))
//                 .toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }
