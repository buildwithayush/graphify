import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/features/data/models/expense.dart';
import 'package:graphify/features/presentation/charts/expense_pie_charts.dart';
import 'package:graphify/features/presentation/providers/expenses.dart';

class ExpenseChartScreen extends ConsumerStatefulWidget {
  const ExpenseChartScreen({super.key});

  @override
  ConsumerState<ExpenseChartScreen> createState() => _ExpenseChartScreenState();
}

class _ExpenseChartScreenState extends ConsumerState<ExpenseChartScreen> {
  @override
  Widget build(BuildContext context) {
    final expenses = ref.watch(expensesProvider).value ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6), 
      appBar: AppBar(
        title: const Text(
          'Analytics',
          style: TextStyle(color: Color(0xFF1F2937), fontWeight: FontWeight.bold, fontSize: 22),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xFF1F2937)),
      ),
      body: expenses.isEmpty
          ? const Center(child: Text('No data available', style: TextStyle(color: Colors.grey)))
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bar Chart Section
                  const Text(
                    'Monthly Overview',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF4B5563)),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 280,
                    padding: const EdgeInsets.fromLTRB(16, 28, 16, 16),
                    decoration: BoxDecoration(
                      
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0F172A).withOpacity(0.12),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        )
                      ],
                    ),
                    child: BarChart(
                      BarChartData(
                        gridData: const FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        titlesData: const FlTitlesData(
                          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        barGroups: buildChartData(expenses, isDarkBg: true),
                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipColor: (_) => Colors.white, 
                            tooltipPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              if (group.x >= expenses.length) return null;
                              final expense = expenses[group.x];
                              return BarTooltipItem(
                                '${expense.category}\n',
                                const TextStyle(color: Color(0xFF4B5563), fontSize: 11),
                                children: [
                                  TextSpan(
                                    text: '₹${expense.amount}',
                                    style: const TextStyle(
                                      color: Color(0xFF1E293B),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 36),

                  // Pie Chart Section
                  const Text(
                    'Expense Distribution',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF4B5563)),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 300,
                    width: double.infinity,
                    padding: const EdgeInsets.all(16), 
                    decoration: BoxDecoration(
                   
                      gradient: const LinearGradient(
                        colors: [Colors.white, Color(0xFFEBF8FF)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        )
                      ],
                    ),
                    child: const Center(
                      child: SizedBox(
                        height: 220,
                        width: 220,  
                        child: ExpensePieCharts(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

List<BarChartGroupData> buildChartData(List<Expense> expenses, {required bool isDarkBg}) {
  return expenses.asMap().entries.map((entry) {
    final index = entry.key;
    final expense = entry.value;

    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: expense.amount?.toDouble() ?? 0.0,
         
          gradient: LinearGradient(
            colors: isDarkBg 
                ? [const Color(0xFF4ADE80), const Color(0xFF22C55E)] 
                : [const Color(0xFF86EFAC), const Color(0xFF4ADE80)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          width: 14,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
        ),
      ],
    );
  }).toList();
}