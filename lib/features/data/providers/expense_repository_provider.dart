import 'package:graphify/features/data/providers/isar_provider.dart';
import 'package:graphify/features/data/repositories/expense_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_repository_provider.g.dart';

@riverpod
Future<ExpenseRepository> expenseRepository(ExpenseRepositoryRef ref)async  {
  final database = await ref.watch(isarProvider.future);

  return ExpenseRepository(database);
}
