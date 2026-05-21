import 'package:graphify/features/presentation/providers/expenses.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_totals_provider.g.dart';
@riverpod

Future<Map<String,double>> categoryTotals(CategoryTotalsRef ref)async{

  
  final expenses = await ref.watch(expensesProvider.future);

  final Map<String,double> totals = {};

  for (final expense in expenses) {
    totals.update(
      expense.category,
      (value) => value + expense.amount!,
      ifAbsent: () => expense.amount!,
    ); 
  }
  return totals;
}