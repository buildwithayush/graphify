import 'package:graphify/features/budget/models/budget.dart';
import 'package:graphify/features/budget/providers/budget_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_month_budget_provider.g.dart';
@riverpod
Stream<Budget?> currentMonthBudget(CurrentMonthBudgetRef ref) async* {
 
  final budgetService = await ref.watch(budgetProvider.future);
  
 
  yield* budgetService.watchCurrentMonthBudget(); 
}