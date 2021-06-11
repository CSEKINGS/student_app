import 'dart:ui';

import 'package:flutter/material.dart';

class GradientColors {
  const GradientColors();

  static const Color loginGradientStart = Color(0xFFfbab66);
  static const Color loginGradientEnd = Color(0xFFf7418c);

  static const primaryGradient = LinearGradient(
    colors: [loginGradientStart, loginGradientEnd],
    stops: [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

final darkTheme = ThemeData(
  primarySwatch: Colors.teal,
  fontFamily: 'Product Sans',
  primaryColor: const Color(0xFF1F1F1F),
  scaffoldBackgroundColor: const Color(0xFF1F1F1F),
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF262626),
  accentColor: Colors.teal,
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(foregroundColor: Colors.white),
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.teal,
  primaryColor: Colors.teal,
  fontFamily: 'Product Sans',
  brightness: Brightness.light,
  backgroundColor: Colors.white,
  accentColor: Colors.teal,
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(foregroundColor: Colors.white),
  dividerColor: Colors.white54,
);
