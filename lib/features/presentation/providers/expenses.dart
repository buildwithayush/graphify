import 'package:graphify/features/data/models/expense.dart';
import 'package:graphify/features/data/providers/expense_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expenses.g.dart';

@riverpod
Stream<List<Expense>> expenses(ExpensesRef ref) async* {
  final repo = await ref.watch(expenseRepositoryProvider.future);

  yield* repo.watchAllExpenses();
}
