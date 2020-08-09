import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/common/login.dart';
import 'package:student_app/common/onboarding_screen.dart';
import 'package:student_app/common/process_data.dart';

String initScreen, classfound;
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
      return ProcessData(initScreen, classfound);
    }
  }

  Future<bool> getSharedVal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    onBoard = prefs.getInt("onBoard");
    await prefs.setInt("onBoard", 1);

    initScreen = prefs.getString('username');
    classfound = prefs.getString('foundedclass');
    return true;
  }
}
