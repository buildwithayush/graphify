import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/features/data/models/expense.dart';
import 'package:graphify/features/data/providers/expense_filter.dart';
import 'package:graphify/features/expenses/enums/expense_filter.dart';
import 'package:graphify/features/presentation/providers/expenses.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filtered_expenses.g.dart';

@riverpod
AsyncValue<List<Expense>> filteredExpenses(Ref ref) {
  final expensesAsync = ref.watch(expensesProvider);
  final filter = ref.watch(expenseFilterNotifierProvider);

  return expensesAsync.whenData((expenses) {
    final now = DateTime.now();
    
    final weekAgo = now.subtract(const Duration(days: 7));
    switch (filter) {
      case ExpenseFilter.today:
        return expenses.where((expense) {
          
          return expense.date!.year == now.year &&
              expense.date!.month == now.month &&
              expense.date!.day == now.day;
        }).toList();
      case ExpenseFilter.week:
        return expenses.where((expenses) {
          return expenses.date!.isAfter(weekAgo);
        }).toList();
      case ExpenseFilter.month:
        return expenses.where((expenses) {
          return expenses.date!.year == now.year &&
              expenses.date!.month == now.month;
        }).toList();
      case ExpenseFilter.year:
        return expenses.where((expenses) {
          return expenses.date!.year == now.year;
        }).toList();
    }
  });
}
