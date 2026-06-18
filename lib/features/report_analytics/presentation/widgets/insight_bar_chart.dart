import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:graphify/features/report_analytics/data/models/insight_model.dart';

class InsightBarChart extends StatelessWidget {
  final List<InsightItem> chartData;
  final String mode;

  const InsightBarChart({
    super.key,
    required this.chartData,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (chartData.isEmpty) {
      return const SizedBox(
        height: 220,
        child: Center(child: Text("No expenses recorded in this period")),
      );
    }

    return Container(
      height: 280, 
      padding: const EdgeInsets.fromLTRB(12, 20, 16, 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 20.0),
            child: Text(
              mode == "weekly"
                  ? "Top Spends (Last 7 Days)"
                  : "Top Spends (Last 30 Days)",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),

          // Main FL Chart Component
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: _getMaxY(),
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => colorScheme.surface,
                    tooltipBorder: BorderSide(
                      color: colorScheme.outlineVariant,
                      width: 1,
                    ),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        "₹${rod.toY.toStringAsFixed(0)}",
                        TextStyle(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index >= 0 && index < chartData.length) {
                          String name = chartData[index].category;
                          if (name.length > 5) {
                            name = "${name.substring(0, 4)}..";
                          }
                          return SideTitleWidget(
                            meta: meta,
                            space: 8,
                            child: Text(
                              name,
                              style: TextStyle(
                                color: colorScheme.onSurfaceVariant,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: const FlGridData(
                  show: false,
                ), 
                borderData: FlBorderData(show: false),
                barGroups: List.generate(chartData.length, (index) {
                  final item = chartData[index];
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: item.currentAmount,
                        color: colorScheme.primary.withValues(alpha: 0.85),
                        width: 18,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(6),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to calculate upper limits dynamically
  double _getMaxY() {
    if (chartData.isEmpty) return 100.0;
    final maxAmt = chartData
        .map((e) => e.currentAmount)
        .reduce((a, b) => a > b ? a : b);
    return maxAmt > 0 ? maxAmt * 1.15 : 100.0; 
  }
}
