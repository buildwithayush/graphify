import 'package:graphify/features/report_analytics/data/models/insight_model.dart';
import 'package:graphify/features/report_analytics/data/repositories/report_analytics_repository.dart';

class ReportAnalyticsService {
  final ReportAnalyticsRepository repository;

  ReportAnalyticsService(this.repository);

  Future<PeriodInsight> calculaterollingInsight(String mode) async {
    final DateTime now = DateTime.now();
    late DateTime currentStart;
    late DateTime previousStart;
    late DateTime previousEnd;

    if (mode == 'weekly') {
      currentStart = now.subtract(const Duration(days: 7));
      previousEnd = currentStart;
      previousStart = currentStart.subtract(const Duration(days: 7));
    } else {
      currentStart = now.subtract(const Duration(days: 30));
      previousEnd = currentStart;
      previousStart = currentStart.subtract(const Duration(days: 30));
    }

    final currentExpenses = await repository.fetchExpenseInRange(
      currentStart,
      now,
    );
    final previousExpense = await repository.fetchExpenseInRange(
      previousStart,
      previousEnd,
    );
    double currentTotal = 0.0;
    double previousTotal = 0.0;

    final Map<String, dynamic> currentMap = {};
    final Map<String, dynamic> previousMap = {};

    for (var e in currentExpenses) {
      currentMap[e.category] = (currentMap[e.category] ?? 0) + e.amount;
      currentTotal += e.amount;
    }

    for (var e in previousExpense) {
      previousMap[e.category] = (previousMap[e.category] ?? 0.0) + e.amount;
      previousTotal += e.amount;
    }

    final List<InsightItem> allInsigts = [];
    final Set<String> allCategories = {...currentMap.keys, ...previousMap.keys};

    for (var cat in allCategories) {
      final double curAmt = currentMap[cat] ?? 0.0;
      final double prevAmt = previousMap[cat] ?? 0.0;
      final double diff = curAmt - prevAmt;

      bool isNewCategory = prevAmt == 0.0 && curAmt > 0.0;
      double pctChange = 0.0;

      if (prevAmt > 0.0) {
        pctChange = (diff / prevAmt) * 100;
      } else if (isNewCategory) {
        pctChange = 100.0;
      }

      allInsigts.add(
        InsightItem(
          category: cat,
          currentAmount: curAmt,
          previousAmount: prevAmt,
          difference: diff,
          isNew: isNewCategory,
          totalPercentageChange: pctChange,
        ),
      );
    }
    double totalPctChange = 0.0;
    if (previousTotal > 0) {
      totalPctChange = ((currentTotal - previousTotal) / previousTotal) * 100;
    }

    final List<InsightItem> chartList = allInsigts
        .where((i) => i.currentAmount > 0)
        .toList();
    chartList.sort((a, b) => b.currentAmount.compareTo(a.currentAmount));
    final top5 = chartList.take(5).toList();

    allInsigts.sort((a, b) => b.currentAmount.compareTo(a.currentAmount));

    return PeriodInsight(
      currentTotal: currentTotal,
      previousTotal: previousTotal,
      totaldifference: currentTotal - previousTotal,
      totalPercentageChnage: totalPctChange,
      topCategoriesForChart: top5,
      allInsights: allInsigts,
    );
  }
}
