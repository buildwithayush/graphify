import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/features/data/models/expense.dart';
import 'package:graphify/features/data/providers/expense_repository_provider.dart';
import 'package:graphify/features/presentation/providers/expenses.dart';
import 'package:graphify/features/presentation/screens/expense_chart_screen.dart';
import 'package:graphify/features/presentation/screens/expense_view.dart';
import 'package:graphify/features/presentation/widgets/Tdate_time_picker.dart';

class ExpenseHomeScreen extends ConsumerStatefulWidget {
  const ExpenseHomeScreen({super.key});

  @override
  ConsumerState<ExpenseHomeScreen> createState() => _ExpenseHomeScreenState();
}

TextEditingController _textEditingController1 = TextEditingController();
TextEditingController _textEditingController2 = TextEditingController();

class _ExpenseHomeScreenState extends ConsumerState<ExpenseHomeScreen> {
  DateTime? expenseDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expenses')),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Text('Add Your Expenses'),
            SizedBox(height: 20),
           TdateTimePicker(
          
            onDateSelected: (selectedDate) {
              expenseDate = selectedDate;
              ref.invalidate(expensesProvider);
              
            },
          ),
            SizedBox(height: 20),
            Container(

              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
              ),
              child: TextFormField(
                controller: _textEditingController1,

                decoration: InputDecoration(hintText: 'Category'),
              ),
            ),
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(shape: BoxShape.rectangle),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _textEditingController2,

                decoration: InputDecoration(hintText: 'Amount'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () async {
                  final repo = await ref.read(expenseRepositoryProvider.future);

                  final expense = Expense(
                    category: _textEditingController1.text,
                    amount:
                        double.tryParse(_textEditingController2.text) ?? 0.0,
                    date: expenseDate,
                  );

                  await repo.addExpense(expense);
                  ref.invalidate(expensesProvider);
                  _textEditingController1.clear();
                  _textEditingController2.clear();
                },
                child: Text('Add Expense'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExpenseView()),
                );
              },
              child: Text('Next Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExpenseChartScreen()),
                );
              },
              child: Text('Charts Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
