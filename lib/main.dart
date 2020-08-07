import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/common/login.dart';
import 'package:student_app/common/onboarding_screen.dart';
import 'package:student_app/common/process_data.dart';

String initScreen, classfound;
int onBoard;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  onBoard = prefs.getInt("onBoard");
  await prefs.setInt("onBoard", 1);

  initScreen = prefs.getString('username');
  classfound = prefs.getString('foundedclass');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'student',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: route(),
    );
  }
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
