import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  ThemeData getTheme() => _themeData;

  void setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}
