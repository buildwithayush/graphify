import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/features/data/models/expense.dart';
import 'package:graphify/features/data/providers/expense_filter.dart';
import 'package:graphify/features/data/providers/search_query.dart';
import 'package:graphify/features/expenses/enums/expense_filter.dart';
import 'package:graphify/features/presentation/providers/expenses.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filtered_expenses.g.dart';

@riverpod
AsyncValue<List<Expense>> filteredExpenses(Ref ref) {
  final expensesAsync = ref.watch(expensesProvider);
  final filter = ref.watch(expenseFilterNotifierProvider);
  final searchQuery = ref.watch(searchQueryProvider);

  return expensesAsync.whenData((expenses) {
    List<Expense> filtered = [];
    final now = DateTime.now();

    final weekAgo = now.subtract(const Duration(days: 7));
    switch (filter) {
      case ExpenseFilter.today:
        filtered = expenses.where((expense) {
          return expense.date.year == now.year &&
              expense.date.month == now.month &&
              expense.date.day == now.day;
        }).toList();
        break;
      case ExpenseFilter.week:
        filtered = expenses.where((expenses) {
          return expenses.date.isAfter(weekAgo);
        }).toList();
        break;
      case ExpenseFilter.month:
        filtered = expenses.where((expenses) {
          return expenses.date.year == now.year &&
              expenses.date.month == now.month;
        }).toList();
        break;
      case ExpenseFilter.year:
        filtered = expenses.where((expenses) {
          return expenses.date.year == now.year;
        }).toList();
        break;
    case ExpenseFilter.alltime:
        filtered = expenses;
        break;

    }
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((expense) {
        return expense.category.toLowerCase().contains(
          searchQuery.toLowerCase(),
        );
      }).toList();
    }
    filtered.sort((a, b) => b.date.compareTo(a.date));

    return filtered;
  });
}
