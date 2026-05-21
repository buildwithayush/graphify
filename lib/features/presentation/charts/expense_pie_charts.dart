import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/features/presentation/providers/category_totals_provider.dart';

class ExpensePieCharts extends ConsumerWidget {
  const ExpensePieCharts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryTotals = ref.watch(categoryTotalsProvider);

    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
    ];

    return categoryTotals.when(
      data: (totals) {
        final sections = totals.entries.toList().asMap().entries.map((entry) {
          final index = entry.key;

          final category = entry.value;

          return PieChartSectionData(
            value: category.value,
            title: category.key,
            radius: 70,

            color: colors[index % colors.length],
          );
        }).toList();

        return PieChart(PieChartData(sections: sections));
      },

      error: (error, stackTrace) => Text(error.toString()),

      loading: () => const CircularProgressIndicator(),
    );
  }
}
