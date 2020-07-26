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
  String age;
  bool isSelected = false;
  String key;
  Item(this.name, this.age);
  Item.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot.data['name'],
        age = snapshot.data['age'].toString(),
        key = snapshot.documentID;
}

class Dbref {
  CollectionReference getProfile(String cls, String yer, String dep) {
    return (Firestore.instance.collection('collage/student/$dep/$yer/$cls'));
  }

  CollectionReference placeAttendance(String cls, String yer, String dep) {
    var datetime = new DateTime.now().toString();
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
