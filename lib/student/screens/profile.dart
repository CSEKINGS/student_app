import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:student_app/common/login.dart';

//class profile extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: const MyHomePage(title: 'Profile'),
//    );
//  }
//}
//
//class MyHomePage extends StatelessWidget {
//  const MyHomePage({Key key, this.title}) : super(key: key);
//  final String title;
//  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
//    return ListTile(
//      title: Row(
//        children: [
//          Expanded(
//            child: Text(
//              document['name'],
//              style: Theme.of(context).textTheme.headline1,
//            ),
//          ),
//          Container(
//            decoration: const BoxDecoration(
//              color: Color(0xffdd),
//            ),
//            padding: const EdgeInsets.all(10.0),
//            child: Text(
//              document['roll no'].toString(),
//              style: Theme.of(context).textTheme.headline4,
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text(title)),
//      body: StreamBuilder(
//        stream: Firestore.instance.collection('profile').snapshots(),
//        builder: (context, snapshot) {
//          if (!snapshot.hasData) return const Text('loading...');
//          return ListView.builder(
//            itemExtent: 80.0,
//            itemBuilder: (context, index) =>
//                _buildListItem(context, snapshot.data.document[index]),
//          );
//        },
//      ),
//    );
//  }
//}
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
//  static LoginPage log = new LoginPage();
//  String jj = log.cc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder(
                stream: Firestore.instance
                    .collection('student')
                    .document('cse')
                    .collection('2017')
                    .document('jj')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return new Text("Loading");
                  }
                  var userDocument = snapshot.data;
                  return new Column(
                    children: <Widget>[
                      Text(userDocument["name"]),
                      Text(userDocument["rollno"]),
                      Text(userDocument["bloodgroup"]),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
