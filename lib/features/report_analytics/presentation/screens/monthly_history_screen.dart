import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/core/utilities/covert_date_format.dart';
import 'package:graphify/features/presentation/widgets/Tdate_time_picker.dart';
import 'package:graphify/features/report_analytics/presentation/providers/report_providers.dart';

class MonthlyHistoryScreen extends ConsumerStatefulWidget {
  const MonthlyHistoryScreen({super.key});

  @override
  ConsumerState<MonthlyHistoryScreen> createState() =>
      _MonthlyHistoryScreenState();
}

class _MonthlyHistoryScreenState extends ConsumerState<MonthlyHistoryScreen> {
  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedMonthYear = "${now.year}-${now.month.toString().padLeft(2, '0')}";
  }

  late String _selectedMonthYear;

  @override
  Widget build(BuildContext context) {
    final reportAsync = ref.watch(
      monthlyReportHistoryProvider(_selectedMonthYear),
    );

    // 2. Theme setup (Dark/Light )
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        title: Text(
          'Monthly History & Analytics',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Month Dropdown Selector
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Month:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),

                  Stack(
                    children: [
                      Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest.withValues(
                            alpha: 0.4,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: colorScheme.outlineVariant.withValues(
                              alpha: 0.6,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_month_rounded,
                              color: colorScheme.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 10),

                            // Selected Month-Year Text
                            Text(
                              _selectedMonthYear,
                              style: TextStyle(
                                color: colorScheme.onSurface,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),

                            Icon(
                              Icons.arrow_drop_down_rounded,
                              color: colorScheme.onSurfaceVariant,
                              size: 22,
                            ),
                          ],
                        ),
                      ),

                      Positioned.fill(
                        child: Opacity(
                          opacity: 0.01,
                          child: TdateTimePicker(
                            onDateSelected: (selectedDate) {
                              final String newRepoKey = convertToRepoKey(
                                selectedDate,
                              );
                              setState(() {
                                _selectedMonthYear = newRepoKey;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 20, thickness: 1),

            // Report Section
            Expanded(
              child: reportAsync.when(
                data: (report) {
                  if (report == null) {
                    return Center(
                      child: Text(
                        "No reports found for this month.",
                        style: TextStyle(
                          color: colorScheme.onSurface.withValues(alpha: 0.5),
                          fontSize: 16,
                        ),
                      ),
                    );
                  }

                  final categories = report.categoryBreakdown.keys.toList();
                  final totalBudget = report.totalBudget;
                  final totalExpense = report.totalExpense;

                  // Budget Text check
                  final budgetText = totalBudget > 0
                      ? '₹${totalBudget.toStringAsFixed(0)}'
                      : 'Not Set';

                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 0,
                              color: colorScheme.surfaceContainerHighest
                                  .withValues(alpha: 0.4),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Budget",
                                      style: TextStyle(
                                        color: colorScheme.onSurface.withValues(
                                          alpha: 0.6,
                                        ),
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      budgetText,
                                      style: TextStyle(
                                        color: colorScheme.onSurface,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              elevation: 0,
                              color: colorScheme.surfaceContainerHighest
                                  .withValues(alpha: 0.4),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Total Spent",
                                      style: TextStyle(
                                        color: colorScheme.onSurface.withValues(
                                          alpha: 0.6,
                                        ),
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '₹${totalExpense.toStringAsFixed(0)}',
                                      style: TextStyle(
                                        color: colorScheme.onSurface,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Category Wise List Breakdown
                      Expanded(
                        child: ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final categoryName = categories[index];
                            final categoryAmount =
                                report.categoryBreakdown[categoryName]!;

                            return Card(
                              elevation: 0,
                              color: colorScheme.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: colorScheme.outlineVariant.withValues(
                                    alpha: 0.2,
                                  ),
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: colorScheme.primaryContainer,
                                  child: Text(
                                    categoryName.isNotEmpty
                                        ? categoryName[0].toUpperCase()
                                        : "?",
                                    style: TextStyle(
                                      color: colorScheme.onPrimaryContainer,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  categoryName,
                                  style: TextStyle(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: Text(
                                  '₹${categoryAmount.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
                error: (error, stack) => Center(
                  child: Text(
                    'Error: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                loading: () => Center(
                  child: CircularProgressIndicator(color: colorScheme.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
