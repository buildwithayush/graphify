import 'package:flutter/material.dart';
import 'package:graphify/core/themes/custom_themes/outline_button_theme.dart';
import 'custom_themes/text_theme.dart';
import 'custom_themes/appbar_theme.dart';
import 'custom_themes/input_decoration_theme.dart';


class TAppTheme {
  TAppTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white, // For Big Main Container 
    
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
      primary: const Color.fromARGB(255, 0, 0, 0), // For Button background 
      outline: const Color(0xFF0F172A), // For Container main border 
    ),
    
    textTheme: TTextTheme.lightTextTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    inputDecorationTheme: TInputDecorationTheme.lightInputDecorationTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0), 
    cardColor: const Color(0xFF1E293B), // For Big Main Container in dark mode
    
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
      primary: Colors.white, // For Button background in dark mode
      outline: Colors.white,
    ),
    
    textTheme: TTextTheme.darkTextTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    inputDecorationTheme: TInputDecorationTheme.darkInputDecorationTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
  );
}