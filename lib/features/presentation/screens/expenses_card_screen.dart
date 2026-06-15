import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/features/budget/providers/budget_service_provider.dart';
import 'package:graphify/features/budget/providers/monthy_total_budget.dart';
import 'package:graphify/features/presentation/widgets/bottom_sheet.dart';
import 'package:graphify/features/presentation/providers/monthlyTotal.dart';
import 'package:graphify/features/presentation/widgets/budget_progress_bar.dart';
import 'package:graphify/features/presentation/widgets/monthy_expense_card.dart';

class ExpensesCardScreen extends ConsumerStatefulWidget {
  const ExpensesCardScreen({super.key});

  @override
  ConsumerState<ExpensesCardScreen> createState() => _ExpensesCardScreenState();
}

class _ExpensesCardScreenState extends ConsumerState<ExpensesCardScreen> {
  @override
  Widget build(BuildContext context) {
    final monthlyExpense = ref.watch(monthlyTotalProvider);
    final monthlyBudget = ref.watch(monthlyTotalBudgetProvider);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Expenses & Budget'),
            Spacer(),
            TextButton(
              onPressed: () async {
                final budget = await ref.read(budgetProvider.future);
                if (!context.mounted) return;
                showBudgetBottomSheet(context, (amount) async {
                  await budget.setBudget(amount);
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Budget updated to ₹$amount')),
                  );
                });
              },
              child: Icon(Icons.edit, size: 21),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: BudgetProgressBar(
              monthlyExpense: monthlyExpense,
              monthlyBudget: double.tryParse(monthlyBudget) ?? 0,
            ),
          ),
          CustomDashboardCard(
            topTitle: 'Monthly Expenenses',
            mainTitle: 'Expenses',
            displayAmount: (monthlyExpense == monthlyExpense.toInt())
                ? monthlyExpense.toInt().toString()
                : monthlyExpense.toString(),
          ),
          CustomDashboardCard(
            topTitle: 'Monthly Budget',
            mainTitle: 'Budget',
            displayAmount: monthlyBudget,
          ),
        ],
      ),
    );
  }
}
