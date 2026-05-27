// core/themes/custom_themes/text_theme.dart
import 'package:flutter/material.dart';

class TTextTheme {
  TTextTheme._();

  static final TextTheme lightTextTheme = TextTheme(
    // Screen title
    titleLarge: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Color(0xFF0F172A),
    ),
    // "Add Your Expenses"
    titleMedium: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color(0xFF0F172A),
    ),
    // "Category" and "Amount"
    bodyMedium: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: Color(0xFF4B5563),
    ),
    // Dropdown/TextField text
    bodyLarge: const TextStyle(fontSize: 15, color: Color(0xFF1F2937)),
  );

  static final TextTheme darkTextTheme = TextTheme(
    titleLarge: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleMedium: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyMedium: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: Color(0xFF9CA3AF),
    ), // Light Grey
    bodyLarge: const TextStyle(fontSize: 15, color: Colors.white),
  );
}
