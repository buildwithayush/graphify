import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/features/presentation/providers/expenses.dart';

class ExpenseView extends ConsumerStatefulWidget {
  const ExpenseView({super.key});

  @override
 ConsumerState<ExpenseView> createState() => _ExpenseViewState();
}

class _ExpenseViewState extends ConsumerState<ExpenseView> {
  @override
  Widget build(BuildContext context) {

    final expensesAsync = ref.watch(expensesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Expenses')),
      body: expensesAsync.when(
        data: (expenses) {
          return ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {

              final expense = expenses[index];

              return Card(
                child: ListTile(
                  title: Text(expense.category),
                  subtitle: Text(
                    expense.amount.toString(),
                  ),
                ),
              );
            },
          );
        },

        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),

        error: (error, stack) => Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }
}