import 'package:cloud_firestore/cloud_firestore.dart';

class Contents {
  String name;
  String key;
  bool isSelected = false;
  Contents(this.name);
  Contents.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot.data['name'],
        key = snapshot.documentID;
}

class Item {
  String name;
  String rollNo;
  bool isSelected = false;
  String key;
  Item(this.name, this.rollNo);
  Item.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot.data['Name'],
        rollNo = snapshot.data['Rollno'].toString(),
        key = snapshot.documentID;
}

class DbRef {
  CollectionReference getProfile(String cls, String yer, String dep) {
    return (Firestore.instance.collection('collage/student/$dep/$yer/$cls'));
  }

  CollectionReference placeAttendance(String cls, String yer, String dep) {
    var datetime = DateTime.now().toString();
    var dateParse = DateTime.parse(datetime);
    var date = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    var hour = "${dateParse.hour}";
    return (Firestore.instance.collection('$dep/$yer/$cls/$date/$hour'));
  }

  CollectionReference getDetailRef(String val) {
    return (Firestore.instance.collection('$val'));
  }

  CollectionReference getDetailRef2(String year, String department) {
    return (Firestore.instance.collection('class/$department/$year'));
  }
}
