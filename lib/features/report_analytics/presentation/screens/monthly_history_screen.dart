import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/features/report_analytics/presentation/providers/report_providers.dart';

class MonthlyHistoryScreen extends ConsumerStatefulWidget {
  const MonthlyHistoryScreen({super.key});

  @override
  ConsumerState<MonthlyHistoryScreen> createState() =>
      _MonthlyHistoryScreenState();
}

class _MonthlyHistoryScreenState extends ConsumerState<MonthlyHistoryScreen> {
  // Default selected month-year key
  String _selectedMonthYear = "2026-06";

  // Dropdown list options
  final List<String> _monthOptions = [
    "2026-06",
    "2026-05",
    "2026-04",
    "2026-03",
    "2026-02",
    "2026-01",
  ];

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
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedMonthYear,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: colorScheme.primary,
                      ),
                      dropdownColor: colorScheme.surface,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedMonthYear = newValue;
                          });
                        }
                      },
                      items: _monthOptions.map<DropdownMenuItem<String>>((
                        String value,
                      ) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
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
