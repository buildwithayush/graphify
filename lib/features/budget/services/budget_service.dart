import 'package:graphify/features/budget/models/budget.dart';
import 'package:isar/isar.dart';

class BudgetService {
  final Isar isar;

  BudgetService(this.isar);

  int _getPeriod(DateTime date) {
    return date.year * 100 + date.month;
  }

  Future<void> setBudget(double amount) async {
    final now = DateTime.now();
    final period = _getPeriod(now);

    final newBudget = Budget()
      ..amount = amount
      ..period = period;

    await isar.writeTxn(() async {
      final existing = await isar.budgets
          .filter()
          .periodEqualTo(period)
          .findFirst();

      if (existing != null) {
        newBudget.id = existing.id;
      }

      await isar.budgets.put(newBudget);
    });
  }

  Future<Budget?> getCurrentMonthBudget() async {
    final now = DateTime.now();
    final period = _getPeriod(now);

    return await isar.budgets.filter().periodEqualTo(period).findFirst();
  }

  Stream<Budget?> watchCurrentMonthBudget() {
    final now = DateTime.now();
    final period = _getPeriod(now);

    return isar.budgets
        .filter()
        .periodEqualTo(period)
        .watch(fireImmediately: true)
        .map((budgets) => budgets.isNotEmpty ? budgets.first : null);
  }
}
