import 'package:graphify/features/presentation/providers/expenses.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'monthlyTotal.g.dart';

@riverpod
double monthlyTotal(MonthlyTotalRef ref) {
  final expenseAsync = ref.watch(expensesProvider);

  return expenseAsync.when(
    data: (expensesList) {
      final now = DateTime.now();

      final monthlyExpenses = expensesList.where((expense) {
        return expense.date.month == now.month &&
            expense.date.year == now.year;
      });

      return monthlyExpenses.fold(
        0.0,
        (sum, expense) => sum + expense.amount,
      );
    },
    error: (error, stackTrace) => 0.0,
    loading: () => 0.0,
  );
}
