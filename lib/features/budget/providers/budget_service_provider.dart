import 'package:graphify/features/budget/services/budget_service.dart';
import 'package:graphify/features/data/providers/isar_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'budget_service_provider.g.dart';

@riverpod
Future<BudgetService> budget(BudgetRef ref) async {
 
  final isar = await ref.watch(isarProvider.future); 
  
  return BudgetService(isar);
}