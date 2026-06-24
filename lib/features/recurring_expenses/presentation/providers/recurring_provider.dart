import 'package:graphify/features/notifications/data/notification_service.dart';
import 'package:graphify/features/recurring_expenses/domain/models/recurring_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recurring_provider.g.dart';

@riverpod
class RecurringController extends _$RecurringController {
  final _notificationService = NotificationService();

  @override
  FutureOr<List<RecurringModel>> build() {
    return [];
  }

  Future<void> registerRecurringExpenses({
    required String category,
    required double amount,
    required int recurringDay,
    required DateTime selectedDate,
  }) async {
   

    try {
      final int uniqueIntId = DateTime.now().millisecondsSinceEpoch.remainder(
        100000,
      );
      final int safeRecurringDay = selectedDate.day > 28
          ? 28
          : selectedDate.day;

      //  Future month auto-log alert system activation
      await _notificationService.scheduleRecurringNotification(
        id: uniqueIntId,
        category: category,
        amount: amount,
        targetDay: safeRecurringDay,
      );
    } catch (error) {
      //
    }
  }

  Future<void> deleteRecurringExpenses(int id) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await _notificationService.cancelAlarm(id);

      final currentList = state.value ?? [];
      return currentList.where((item) => item.id != id).toList();
    });
  }
}
