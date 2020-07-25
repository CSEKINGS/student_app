import 'package:flutter/material.dart';
import 'Designs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Home page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        ),
      drawer: Container(
        width: 210,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                    Colors.lightBlue,
                    Colors.lightBlueAccent
                  ])
                ),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Text('Header',style: TextStyle(fontSize: 20),),
                     ],
                  ),
                ),
              ),
              CustomView('Add class'),
              CustomView('Add student'),
              CustomView('Attendance'),
              CustomView('Add year'),
              CustomView('Add dep'),
              CustomView('Delete students'),
              CustomView('Delete class'),
              CustomView('Delete department'),
              CustomView('Delete year'),
            ],
          ),
        ),
      ),
    );
  }
}
