import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/features/data/providers/expense_repository_provider.dart';
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
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Amount: \$${expense.amount}'),
                      Text('Date: ${expense.date}'),
                    ],
                  ),
                  
                  trailing: IconButton(
                    icon: const Icon(Icons.delete,color: Colors.red,),
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
    );
  }
}
