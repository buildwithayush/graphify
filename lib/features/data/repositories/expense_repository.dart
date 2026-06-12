import 'package:graphify/features/data/models/expense.dart';
import 'package:isar/isar.dart';

class ExpenseRepository {
  final Isar isar;

  ExpenseRepository(this.isar);


  Future<void> addExpense(Expense expense) async {
    await isar.writeTxn(() async {
      await isar.expenses.put(expense);
    });
  }

  Stream<List<Expense>> watchAllExpenses(){
       return isar.expenses.where().watch(fireImmediately: true);
  }

  // Update Expense
  Future<void> updateExpense(Expense expense) async {
    await isar.writeTxn(() async {
      await isar.expenses.put(expense);
    });
  }

  // Delete Expense
  Future<void> deleteExpense(int id) async {
    await isar.writeTxn(() async {
      await isar.expenses.delete(id);
    });
  }
}