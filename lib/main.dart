import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/common/login.dart';
import 'package:student_app/common/onboarding_screen.dart';
import 'package:student_app/common/process_data.dart';

String initScreen, classFound;
int onBoard;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<bool>(
        future: getSharedVal(),
        builder: (buildContext, snapshot) {
          if (snapshot.hasData) {
            return route();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget route() {
    if (onBoard == 0 || onBoard == null) {
      return OnBoardingPage();
    } else if (initScreen == '' || initScreen == null) {
      return LoginPage();
    } else {
      return ProcessData(initScreen, classFound);
    }
  }

  Future<bool> getSharedVal() async {
    var prefs = await SharedPreferences.getInstance();
    onBoard = prefs.getInt('onBoard');
    await prefs.setInt('onBoard', 1);

    initScreen = prefs.getString('username');
    classFound = prefs.getString('foundedclass');
    return true;
  }
}
