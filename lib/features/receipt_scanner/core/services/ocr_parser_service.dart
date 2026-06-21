import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:graphify/features/receipt_scanner/domain/models/parsed_recipt.dart';

class OcrParserService {
  final TextRecognizer _textRecognizer = TextRecognizer(
    script: TextRecognitionScript.latin,
  );

  Future<ParsedReceipt> parsedReciptImage(File imageFile) async {
    try {
      final InputImage inputImage = InputImage.fromFile(imageFile);
      final RecognizedText recognizedText = await _textRecognizer.processImage(
        inputImage,
      );
      final String rawText = recognizedText.text.toUpperCase();
      final List<String> lines = recognizedText.blocks
          .map((b) => b.text.toUpperCase())
          .toList();

      // First Validation Layer : Empty Text Check Guard
      if (lines.length < 3 || rawText.trim().isEmpty) {
        throw Exception(
          'Invalid Image : No readable text found . Please Upload a clear bill',
        );
      }
      // Second Validation Layer
      if (!_isValidReceipt(rawText)) {
        throw Exception(
          "Validation Failed: This image does not contain financial invoice anchors.",
        );
      }

      final double parsedAmount = _extractAmount(rawText);
      final DateTime parsedDate = _extractDate(rawText);

      final String temporaryTitle = recognizedText.blocks.isNotEmpty
          ? recognizedText.blocks.first.text
          : "";
      final String parsedCategory = _predictCategory(temporaryTitle, rawText);
      return ParsedReceipt(
        amount: parsedAmount,
        category: parsedCategory,
        date: parsedDate,
      );
    } catch (e) {
      rethrow;
    }
  }

  bool _isValidReceipt(String text) {
    final List<String> financialKeyword = [
      "TOTAL",
      "GRAND TOTAL",
      "AMOUNT",
      "INVOICE",
      "CASH",
      "PRICE",
      "TAX",
      "GST",
      "STORES",
      "SALE",
      "BILL",
      "ITEMS",
    ];

    int matchCount = 0;
    for (var keyword in financialKeyword) {
      if (text.contains(keyword)) {
        matchCount++;
      }
    }

    return matchCount >= 2;
  }

  DateTime _extractDate(String text) {
    final RegExp dataRegex = RegExp(
      r'\b(\d{1,2})[\/\-](\d{1,2})[\/\-](\d{2,4})\b',
    );
    final match = dataRegex.firstMatch(text);

    if (match != null) {
      try {
        int day = int.parse(match.group(1)!);
        int month = int.parse(match.group(2)!);
        int year = int.parse(match.group(3)!);
        if (year < 100) year += 2000;
        return DateTime(year, month, day);
      } catch (_) {}
    }
    return DateTime.now();
  }

  double _extractAmount(String text) {
    final RegExp amountRegex = RegExp(r'\b\d+[\.,]\d{2}\b');
    final Iterable<RegExpMatch> matches = amountRegex.allMatches(text);
    double maxAmount = 0.0;

    for (var match in matches) {
      String clearStr = match.group(0)!.replaceAll(',', '');
      double? parsedValue = double.tryParse(clearStr);
      if (parsedValue != null && parsedValue > maxAmount) {
        maxAmount = parsedValue;
      }
    }
    return maxAmount;
  }

  String _predictCategory(String title, String rawText) {
    final String combined = "$title $rawText".toUpperCase();

    if (combined.contains("ZOMATO") ||
        combined.contains("SWIGGY") ||
        combined.contains("MCDONALD") ||
        combined.contains("RESTAURANT") ||
        combined.contains("CAFE") ||
        combined.contains("FOOD")) {
      return "Food";
    }
    if (combined.contains("BLINKIT") ||
        combined.contains("DMART") ||
        combined.contains("GROCERY") ||
        combined.contains("SUPERMARKET") ||
        combined.contains("SPENCERS")) {
      return "Groceries";
    }
    if (combined.contains("ZARA") ||
        combined.contains("H&M") ||
        combined.contains("CLOTHES") ||
        combined.contains("SHOPPING") ||
        combined.contains("MYNTRA") ||
        combined.contains("AMAZON")) {
      return "Shopping";
    }
    if (combined.contains("UBER") ||
        combined.contains("OLA") ||
        combined.contains("PETROL") ||
        combined.contains("FUEL") ||
        combined.contains("METRO")) {
      return "Transport";
    }
    return "Other";
  }

  void dispose() {
    _textRecognizer.close();
  }
}
