import 'package:graphify/features/data/models/expense.dart';
import 'package:isar/isar.dart';

class ReportAnalyticsRepository {
  final Isar isar;

  ReportAnalyticsRepository(this.isar);

  Future<List<Expense>> fetchExpenseInRange(
    DateTime start,
    DateTime end,
  ) async {
    return await isar.expenses
        .filter()
        .dateGreaterThan(start, include: true)
        .dateLessThan(end, include: true)
        .findAll();
  }
}
