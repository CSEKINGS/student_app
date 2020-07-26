import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'DbAndRefs.dart';

// ignore: must_be_immutable
class Attendance extends StatefulWidget {
  String yer,dep,text;
  Attendance(this.yer,this.dep,this.text);

  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {

  String cls;
  List<Contents> classes=List();
  List<Item> item=List();
  Dbref obj=new Dbref();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    CollectionReference reference;
    if(widget.text=='Delete students'||
        widget.text=='Attendance'||
        widget.text=='Delete class'){
      reference=obj.getDetailRef2(widget.yer,widget.dep);
      reference.snapshots().listen((event) {
        setState(() {
          for (int i=0; i<event.documents.length;i++){
            classes.add(Contents.fromSnapshot(event.documents[i]));
          }
        });
      });
    }
    else if(widget.text=='Delete department'){
      setState(() {
        reference=obj.getDetailRef('department');
        reference.snapshots().listen((event) {
          setState(() {
            for (int i=0; i<event.documents.length;i++){
              classes.add(Contents.fromSnapshot(event.documents[i]));
            }
          });
        });
      });
    }
    else if(widget.text=='Delete year'){
      setState(() {
        reference=obj.getDetailRef('year');
        reference.snapshots().listen((event) {
          setState(() {
            for (int i=0; i<event.documents.length;i++){
              classes.add(Contents.fromSnapshot(event.documents[i]));
            }
          });
        });
      });
    }
  }

  void _clearData(){
    setState(() {
      item.clear();
    });
  }

  void _clearData1(){
    setState(() {
      classes.clear();
    });
  }

  void _getStudent(){
    _clearData();
    CollectionReference ref=obj.getProfile(cls, widget.yer, widget.dep);
    ref.snapshots().listen((event) {
      setState(() {
        for (int i=0; i<event.documents.length;i++){
          item.add(Item.fromSnapshot(event.documents[i]));
        }
      });
    });
  }

  void _addAttendance(){
    CollectionReference ref1=obj.placeAttendance(cls,widget.yer,widget.dep);
    for (int i=0;i<item.length;i++){
      ref1.add(
          {
            'name':item[i].name,
            'attendance':item[i].isSelected?'present':'absent'
          }
      );
    }
  }

   void _delete(){
     CollectionReference ref1=obj.getProfile(cls,widget.yer,widget.dep);
     for (int i=0;i<item.length;i++){
       if (item[i].isSelected){
         ref1.document(item[i].key).delete();
       }
     }
   }

   void _deleteDep(){
    CollectionReference ref1=obj.getDetailRef('department');
    for (int i=0;i<classes.length;i++){
      if (classes[i].isSelected){
        ref1.document(classes[i].key).delete();
      }
    }
   }

   void _deleteYear(){
     CollectionReference ref1=obj.getDetailRef('year');
     for (int i=0;i<classes.length;i++){
       if (classes[i].isSelected){
         ref1.document(classes[i].key).delete();
       }
     }
   }

   void _deleteClass(){
     CollectionReference ref1=obj.getDetailRef2(widget.yer, widget.dep);
     for (int i=0;i<classes.length;i++){
       if (classes[i].isSelected){
         ref1.document(classes[i].key).delete();
       }
     }
   }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Selections'),
      ),
      body: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              (widget.text=='Delete students'||widget.text=='Attendance')?
                  DropdownButton(
                  hint: Text('select class'),
                  onChanged: (name){
                    setState(() {
                      cls=name;
                      _getStudent();
                    });
                  },
                  value: cls,
                  items: classes.map((e) => DropdownMenuItem(
                    child: Text(e.name),
                    value: e.name,
                    )).toList(),
                  ):Container(),

              (widget.text=='Delete students'||widget.text=='Attendance')?
                  ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10),
                  itemCount: item.length,
                  itemBuilder: (context,int index)=>Container(
                      color: item[index].isSelected
                          ?Colors.lightBlueAccent:Colors.white,
                      child: ListTile(
                        title: new Text(item[index].name),
                        subtitle: Text(item[index].age.toString()),
                        onTap: (){
                          setState(() {
                            item[index].isSelected=false;
                          });
                        },
                        onLongPress: (){
                          setState(() {
                            item[index].isSelected=true;
                          });
                        },
                      )
                  )
              ):
              ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10),
                  itemCount: classes.length,
                  itemBuilder: (context,int index)=>Container(
                      color: classes[index].isSelected
                          ?Colors.lightBlueAccent:Colors.white,
                      child: ListTile(
                        title: new Text(classes[index].name),
                        onTap: (){
                          setState(() {
                            classes[index].isSelected=false;
                          });
                        },
                        onLongPress: (){
                          setState(() {
                            classes[index].isSelected=true;
                          });
                        },
                      )
                  )
              ),
              RaisedButton(
                child: Text('Submit'),
                color: Colors.lightBlueAccent,
                onPressed: (){
                  if(widget.text=='Delete students'){
                    _delete();
                  }
                  else if(widget.text=='Attendance'){
                    _addAttendance();
                  }
                  else if(widget.text=='Delete department'){
                    _deleteDep();
                    _clearData1();
                  }
                  else if(widget.text=='Delete year'){
                    _deleteYear();
                    _clearData1();
                  }
                  else if(widget.text=='Delete class'){
                    _deleteClass();
                    _clearData1();
                  }
                },
              )
            ],
          ),
        ),
    );
  }
}
