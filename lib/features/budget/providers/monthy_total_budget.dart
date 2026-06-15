import 'package:graphify/features/budget/providers/current_month_budget_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'monthy_total_budget.g.dart';

@riverpod
String monthlyTotalBudget(MonthlyTotalBudgetRef ref) {
  final budgetAsync = ref.watch(currentMonthBudgetProvider);

  return budgetAsync.when(
    data: (budgetObject) =>
        (budgetObject == null) ? 'Not Set' : budgetObject.amount.toString(),
    error: (error, stackTrace) => 'Not Set',
    loading: () => '...',
  );
}
