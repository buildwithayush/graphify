import 'package:graphify/features/data/models/expense.dart';
import 'package:graphify/features/data/providers/expense_repository_provider.dart';
import 'package:graphify/features/report_analytics/presentation/providers/report_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_notifier.g.dart';

@riverpod
class ExpenseNotifier extends _$ExpenseNotifier {
  @override
  FutureOr<void> build() {}

  Future<void> handleAddExpense({
    required String category,
    required String amount,
    required DateTime? selectedDate,
  }) async {
    state = const AsyncValue.loading();

    try {
      final double parsedAmount = double.tryParse(amount) ?? 0;
      final DateTime finalDate = selectedDate ?? DateTime.now();

      final expense = Expense(
        date: finalDate,
        amount: parsedAmount,
        category: category,
      );
      final repo = ref.watch(expenseRepositoryProvider);
      final reportService = ref.watch(reportServiceProvider);
      await repo.addExpense(expense);
      await repo.expenseSyncReport(
        id: expense.id,
        date: finalDate,
        reportService: reportService,
      );
    } catch (e) {
      //
    }
  }
}
