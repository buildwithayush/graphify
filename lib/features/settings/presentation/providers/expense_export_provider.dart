import 'package:graphify/core/services/csv_export_service.dart';
import 'package:graphify/features/data/models/expense.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_export_provider.g.dart';

@riverpod
CsvExportService csvExportService(CsvExportServiceRef ref) {
  return CsvExportService();
}

@riverpod
class ExpenseExportController extends _$ExpenseExportController {
  @override
  void build() {
    return;
  }

  Future<void> triggerCsvExport({
    required List<Expense> allExpenses,
    required String filterMode,
  }) async {
    final DateTime now = DateTime.now();
    List<Expense> filteredList = [];
    String label = "All_Time";

    if (filterMode == "Last 7 Days") {
      final sevenDaysAgo = now.subtract(const Duration(days: 7));
      filteredList = allExpenses.where((e) => e.date.isAfter(sevenDaysAgo)).toList();
      label = "Last_7_Days";
    } else if (filterMode == "Last 30 Days") {
      final thirtyDaysAgo = now.subtract(const Duration(days: 30));
      filteredList = allExpenses.where((e) => e.date.isAfter(thirtyDaysAgo)).toList();
      label = "Last_30_Days";
    } else {
      filteredList = allExpenses;
      label = "All_Time";
    }

    final exportService = ref.read(csvExportServiceProvider);
    

    await exportService.exportExpensesToCsv(
      expenses: filteredList,
      periodLabel: label,
    );
  }
}