import 'package:flutter/material.dart';

class TAppColors {
  TAppColors._();


  static const Color lightBg = Colors.white;
  static const Color lightText = Color(0xFF0F172A); // Premium Dark Slate
  static const Color lightCard = Color(0xFFF1F5F9);

  static const Color darkBg = Color(0xFF0F172A);
  static const Color darkText = Colors.white;
  static const Color darkCard = Color(0xFF1E293B);


  static bool isDarkMode(BuildContext context) {
  
    return MediaQuery.of(context).platformBrightness == Brightness.dark || 
           Theme.of(context).brightness == Brightness.dark;
  }

 
  static Color background(BuildContext context) => isDarkMode(context) ? darkBg : lightBg;
  static Color text(BuildContext context) => isDarkMode(context) ? darkText : lightText;
  static Color card(BuildContext context) => isDarkMode(context) ? darkCard : lightCard;
}