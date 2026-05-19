import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/features/data/models/expense.dart';
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
      appBar: AppBar(
        title: Text('Charts Screen'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            
            height: 500,
            width: 400,
            child: Card(
              child: BarChart(
                BarChartData(
                  
                  barGroups: buildChartData(expenses),
                  barTouchData: BarTouchData(
                    enabled: true,
            
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final expense = expenses[group.x];
            
                        return BarTooltipItem(
                          '${expense.category}\n'
                          '${expense.amount}',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  
                ),
                
              ),
            ),
          ),
        ],
      ),
    );
  }
}


List<BarChartGroupData> buildChartData(
  List<Expense> expenses,
) {
  return expenses.asMap().entries.map((entry) {

    final index = entry.key;
    final expense = entry.value;

    return BarChartGroupData(
      x: index,

      showingTooltipIndicators: [0],

      barRods: [
        BarChartRodData(
          toY: expense.amount!,
          width: 20,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }).toList();
}