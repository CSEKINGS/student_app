import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/controllers/process_data.dart';
import 'package:student_app/views/utils/theme/theme.dart';
import 'package:student_app/views/utils/theme/theme_notifier.dart';
import 'package:student_app/views/common/common_screens.dart';

String? initScreen, classFound;
int? onBoard;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await SharedPreferences.getInstance().then((prefs) {
    var darkModeOn = prefs.getBool('darkMode') ?? true;
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (context) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
        child: MyApp(),
      ),
    );
  });
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
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      home: FutureBuilder<bool>(
        future: getSharedVal(),
        builder: (buildContext, snapshot) {
          if (snapshot.hasData) {
            return route();
          } else {
            return SizedBox(
              height: 100.0,
              width: 100.0,
              child: Center(
                child: Image.asset("assets/graduates.png"),
              ),
            );
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
