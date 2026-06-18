import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/features/report_analytics/presentation/providers/report_insights_provider.dart';
import 'package:graphify/features/report_analytics/presentation/screens/monthly_history_screen.dart';
import 'package:graphify/features/report_analytics/presentation/widgets/insight_bar_chart.dart';
import 'package:graphify/features/report_analytics/presentation/widgets/insight_bottom_sheet.dart';


class ReportAnalyticsScreen extends ConsumerStatefulWidget {
  const ReportAnalyticsScreen({super.key});

  @override
  ConsumerState<ReportAnalyticsScreen> createState() => _ReportAnalyticsScreenState();
}

class _ReportAnalyticsScreenState extends ConsumerState<ReportAnalyticsScreen> {

  // Mode state: weekly or monthly
  String _selectedMode = "weekly"; 

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    
    final insightsAsync = ref.watch(rollingInsightsProvider(_selectedMode));

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Analytics'),
            Spacer(),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MonthlyHistoryScreen();
                    },
                  ),
                );
              },
              icon: Icon(Icons.more),
            ),
          ],
        )
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  TOGGLE SWITCH MECHANISM
            Center(
              child: Container(
                height: 40,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildToggleOption("weekly", "Weekly"),
                    _buildToggleOption("monthly", "Monthly"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            insightsAsync.when(
              data: (insightData) {
                final bool isSpentMore = insightData.totaldifference > 0;
                final String periodName = _selectedMode == "weekly" ? "last 7 days" : "last 30 days";
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "In the $periodName, your total spending is ₹${insightData.currentTotal.toStringAsFixed(0)}, which is ${insightData.totalPercentageChnage.abs().toStringAsFixed(1)}% ${isSpentMore ? 'higher than' : 'lower than'} the prior period.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    //  CHART WIDGET
                    InsightBarChart(
                      chartData: insightData.topCategoriesForChart, 
                      mode: _selectedMode,
                    ),
                    const SizedBox(height: 20),

                    //  MORE DETAILS 
                    Center(
                      child: TextButton.icon(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => InsightsBottomSheet(
                              allInsights: insightData.allInsights,
                              mode: _selectedMode,
                            ),
                          );
                        },
                        icon: const Icon(Icons.insights_rounded, size: 18),
                        label: const Text("View Detailed Comparison", style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                );
              },
              error: (err, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Text("Failed to load insights: $err"),
                ),
              ),
              loading: () => const Center(
                child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: 60.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleOption(String modeKey, String label) {
    final isSelected = _selectedMode == modeKey;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          setState(() {
            _selectedMode = modeKey;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}