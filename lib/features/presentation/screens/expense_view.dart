import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/features/data/providers/expense_repository_provider.dart';
import 'package:graphify/features/presentation/providers/expenses.dart';
import 'package:graphify/features/presentation/providers/monthlyTotal.dart';

class ExpenseView extends ConsumerStatefulWidget {
  const ExpenseView({super.key});

  @override
  ConsumerState<ExpenseView> createState() => _ExpenseViewState();
}

class _ExpenseViewState extends ConsumerState<ExpenseView> {
  @override
  Widget build(BuildContext context) {
    final expensesAsync = ref.watch(expensesProvider);
    final monthlyExpense = ref.watch(monthlyTotalProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Expenses')),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 4,
            color: Colors.blue.shade50, // Thoda premium look dene ke liye color
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Monthly Total:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${monthlyExpense.toStringAsFixed(2)}', // Double ko 2 decimal tak dikhane ke liye
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: expensesAsync.when(
              data: (expenses) {
                return ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final expense = expenses[index];

                    return Card(
                      child: ListTile(
                        title: Text(expense.category),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Amount: \$${expense.amount}'),
                            Text('Date: ${expense.date}'),
                          ],
                        ),

                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final repo = await ref.read(
                              expenseRepositoryProvider.future,
                            );
                            await repo.deleteExpense(expense.id);
                            ref.invalidate(expensesProvider);
                          },
                        ),
                      ),
                    );
                  },
                );
              },

              loading: () => const Center(child: CircularProgressIndicator()),

              error: (error, stack) => Center(child: Text(error.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
