// core/themes/custom_themes/appbar_theme.dart
import 'package:flutter/material.dart';

class TAppBarTheme {
  TAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Color(0xFF0F172A)),
    actionsIconTheme: IconThemeData(color: Color(0xFF0F172A)),
  );

  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.white),
    actionsIconTheme: IconThemeData(color: Colors.white),
  );
}