import 'dart:io';
import 'package:graphify/features/data/models/expense.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class CsvExportService {
  Future<void> exportExpensesToCsv({
    required List<Expense> expenses,
    required String periodLabel,
  }) async {
    try {
      if (expenses.isEmpty) {
        throw Exception('No data available to export');
      }

      final List<String> csvRows = [];
      csvRows.add("Date,Category,Amount");

      for (var expense in expenses) {
        final String formattedDate = DateFormat('yyyy-MM-dd').format(expense.date);

        final String row =
            '$formattedDate,${expense.category},${expense.amount}';
        csvRows.add(row);
      }

      String csvContent = csvRows.join('\n');

      Directory tempDir = await getTemporaryDirectory();

      final String fileName =
          "Expense_Report_${periodLabel.replaceAll(' ', '_')}.csv";
      final String filePath = "${tempDir.path}/$fileName";

      final File csvFile = File(filePath);
      await csvFile.writeAsString(csvContent);

      final XFile xfile = XFile(filePath);
      await Share.shareXFiles([
        xfile,
      ], text: "Here is your Expense Report for $periodLabel 📊");
    } catch (e) {
      throw Exception("Failed to generate and Share CSV : $e");
    }
  }
}