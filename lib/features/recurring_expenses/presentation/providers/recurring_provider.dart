import 'package:graphify/features/data/models/expense.dart';
import 'package:graphify/features/notifications/data/notification_service.dart';
import 'package:graphify/features/recurring_expenses/domain/models/recurring_model.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recurring_provider.g.dart';

@riverpod
class RecurringController extends _$RecurringController {
  final _notificationService = NotificationService();

  @override
  FutureOr<List<RecurringModel>> build() async {
    final isar = Isar.getInstance();
    if (isar == null) return [];

    return await isar.recurringModels.where().findAll();
  }

  Future<void> addRecurringRule(RecurringModel newRule) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final isar = Isar.getInstance();
      if (isar != null) {
        await isar.writeTxn(() async {
          await isar.recurringModels.put(newRule);
        });
      }
      final isarInstance = Isar.getInstance();
      return await isarInstance!.recurringModels.where().findAll();
    });
  }

  Future<void> checkAndLogPendingRecurringExpenses() async {
    final isar = Isar.getInstance();
    if (isar == null) return;

    final now = DateTime.now();
    final recurringList = await isar.recurringModels.where().findAll();

    for (final item in recurringList) {
      bool isAlreadyLoggedThisMonth =
          item.lastLoggedDate != null &&
          item.lastLoggedDate!.year == now.year &&
          item.lastLoggedDate!.month == now.month;

      if (!isAlreadyLoggedThisMonth && now.day >= item.recurringDay) {
        final newExpense = Expense(
          date: DateTime(now.year, now.month, item.recurringDay),
          amount: item.amount,
          category: item.category,
        );

        await _notificationService.showInstantRecurringNotification(
          id: item.id,
          category: item.category,
          amount: item.amount,
        );

        item.lastLoggedDate = DateTime(now.year, now.month, item.recurringDay);

        await isar.writeTxn(() async {
          await isar.expenses.put(newExpense);
          await isar.recurringModels.put(item);
        });
      }
    }
  }

  Future<void> deleteRecurringExpenses(int id) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final isar = Isar.getInstance();

      if (isar != null) {
        await isar.writeTxn(() async {
          await isar.recurringModels.delete(id);
        });
      }

      final currentList = state.value ?? [];
      return currentList.where((item) => item.id != id).toList();
    });
  }
}
