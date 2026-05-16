import 'package:graphify/features/data/providers/isar_provider.dart';
import 'package:graphify/features/data/repositories/expense_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_repository_provider.g.dart';

@riverpod
ExpenseRepository expenseRepository(ExpenseRepositoryRef ref)  {
  final database =  ref.watch(isarProvider).requireValue;

  return ExpenseRepository(database);
}
