import 'package:graphify/features/budget/providers/current_month_budget_provider.dart';
import 'package:graphify/features/presentation/providers/monthlyTotal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'monthy_total_budget.g.dart';

@riverpod
double monthlyTotalBudget(MonthlyTotalRef ref) {
  final budgetAsync = ref.watch(currentMonthBudgetProvider);

  return budgetAsync.when(
    data: (budgetObject) => budgetObject?.amount ?? 0.0,
    error: (error, stackTrace) => 0.0,
    loading: () => 0.0,
  );
}