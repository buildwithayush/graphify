import 'dart:convert';

import 'package:isar/isar.dart';

part 'monthly_report_model.g.dart';

@collection
class MonthlyReport {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String monthYear;

  late double totalExpense;

  late double totalBudget;

  late String categoryJson;

  set categoryBreakdown(Map<String, dynamic> map) {
    categoryJson = jsonEncode(map);
  }

  @ignore
  Map<String, dynamic> get categoryBreakdown {
    if (categoryJson.isEmpty) return {};
    final decode = jsonDecode(categoryJson) as Map<String, dynamic>;
    return decode.map((key, value) => MapEntry(key, (value as num).toDouble()));
  }
}
