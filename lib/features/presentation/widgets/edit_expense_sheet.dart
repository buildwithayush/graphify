import 'package:flutter/material.dart';
import 'package:graphify/features/presentation/widgets/edit_expense_sheet_content.dart';


void showEditExpenseSheet({
  required BuildContext context,
  required DateTime initialDate,
  required String initialCategory,
  required double initialAmount,
  required Function(DateTime date, String category, double amount) onEditExpense,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, 
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      
      return EditExpenseSheetContent(
        initialDate: initialDate,
        initialCategory: initialCategory,
        initialAmount: initialAmount,
        onEditExpense: onEditExpense,
      );
    },
  );
}