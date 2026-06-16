import 'package:graphify/features/data/models/expense.dart';
import 'package:graphify/features/report_analytics/data/models/monthly_report_model.dart';
import 'package:graphify/features/report_analytics/data/repositories/report_repository.dart';

class ReportService {
 final ReportRepository _reportRepository;

  ReportService(this._reportRepository);

  Future<void> computeAndSaveReport({
    required List<Expense> allExpenses,
    required int month,
    required int year,
     double? budget,
  }) async {
    
    double totalExpense = 0.0;
    final Map<String, dynamic> categoryMap = {};

    final currentMonthExpenses = allExpenses.where(
      (e) => e.date.month == month && e.date.year == year,
    );

    for (var expense in currentMonthExpenses) {
      totalExpense += expense.amount;
      categoryMap[expense.category] =
          (categoryMap[expense.category] ?? 0.0) + expense.amount;
    }
    final String monthYearKey = "$year-${month.toString().padLeft(2, '0')}";
    final existingReport = await _reportRepository.fetchReportsByMonths(monthYearKey);
    final double finalBudget = budget ?? existingReport?.totalBudget ?? 0.0;
    final report = MonthlyReport()
      ..monthYear = monthYearKey
      ..totalBudget = finalBudget
      ..totalExpense = totalExpense
      ..categoryBreakdown = categoryMap;

    await _reportRepository.saveReport(report);
  }
}
