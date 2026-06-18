class InsightItem {
  final String category;
  final double currentAmount;
  final double previousAmount;
  final double totalPercentageChange;
  final double difference;
  final bool isNew;

  InsightItem({
    required this.category,
    required this.currentAmount,
    required this.previousAmount,
    required this.totalPercentageChange,
    required this.difference,
    required this.isNew,
  });
}

class PeriodInsight {
  final double currentTotal;
  final double previousTotal;
  final double totaldifference;
  final double totalPercentageChnage;
  final List<InsightItem> topCategoriesForChart;
  final List<InsightItem> allInsights;

  PeriodInsight({
    required this.currentTotal,
    required this.previousTotal,
    required this.totaldifference,
    required this.totalPercentageChnage,
    required this.topCategoriesForChart,
    required this.allInsights,
  });
}
