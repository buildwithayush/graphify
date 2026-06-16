import 'package:graphify/features/data/models/expense.dart';
import 'package:graphify/features/report_analytics/data/services/report_service.dart';
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

  Future<List<Expense>> getAllExpenses() async {
    return await isar.expenses.where().findAll();
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

  Future<void> expenseSyncReport({
    required int id,
    required DateTime date,
    required ReportService reportService,
  }) async {
    
    Future.delayed(const Duration(milliseconds: 500), () async {
      try {
        final allExpenses = await isar.expenses.where().findAll();
        await reportService.computeAndSaveReport(
          allExpenses: allExpenses,
          month: date.month,
          year: date.year,
         
        );
        
      } catch (e) {
   //
      }
    });
  }
}
