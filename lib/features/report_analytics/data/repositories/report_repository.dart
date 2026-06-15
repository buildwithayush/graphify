import 'package:graphify/features/report_analytics/data/models/monthly_report_model.dart';
import 'package:isar/isar.dart';

class ReportRepository {
  final Isar _isar;

  ReportRepository(this._isar);

  Future<void> saveReport(MonthlyReport report) async {
    await _isar.writeTxn(() async {
      await _isar.monthlyReports.put(report);
    });
  }

  Future<MonthlyReport?> fetchReportsByMonths(String monthYear) async {
    return await _isar.monthlyReports
        .where()
        .monthYearEqualTo(monthYear)
        .findFirst();
  }

  Stream<MonthlyReport?> watchReportsByMonths(String monthYear) {
    return _isar.monthlyReports
        .filter()
        .monthYearEqualTo(monthYear)
        .watch(fireImmediately: true)
        .map((reports) => reports.isNotEmpty ? reports.first : null);
  }

  Future<List<MonthlyReport>> fetchYearlyReports(String year) async {
    return await _isar.monthlyReports
        .filter()
        .monthYearStartsWith(year)
        .findAll();
  }
}
