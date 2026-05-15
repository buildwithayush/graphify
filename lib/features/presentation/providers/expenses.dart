import 'package:graphify/features/data/models/expense.dart';
import 'package:graphify/features/data/providers/expense_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expenses.g.dart';
@riverpod
Future<List<Expense>> expenses(ExpensesRef ref) async {
  final repo = ref.watch(expenseRepositoryProvider);

  return repo.getAllExpenses();
}