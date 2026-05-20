import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/features/data/models/expense.dart';
import 'package:graphify/features/data/providers/expense_repository_provider.dart';
import 'package:graphify/features/presentation/providers/category_provider.dart';
import 'package:graphify/features/presentation/providers/expenses.dart';
import 'package:graphify/features/presentation/screens/expense_chart_screen.dart';
import 'package:graphify/features/presentation/screens/expense_view.dart';
import 'package:graphify/features/presentation/widgets/Tdate_time_picker.dart';

class ExpenseHomeScreen extends ConsumerStatefulWidget {
  const ExpenseHomeScreen({super.key});

  @override
  ConsumerState<ExpenseHomeScreen> createState() => _ExpenseHomeScreenState();
}

List<String> categories = [
  'Food',
  'Study',
  'Utilities',
  'Transportation',
  'Insurance',
  'Custom',
];

class _ExpenseHomeScreenState extends ConsumerState<ExpenseHomeScreen> {
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();

  @override
  void dispose() {
    _textEditingController1.dispose();
    _textEditingController2.dispose();
    super.dispose();
  }

  DateTime? expenseDate;
  bool isCustomSelected = false;

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryNotifierProvider);
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
            DropdownButton<String>(
              value: categoryState.selectedcategory,

              items: categories.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  ref
                      .read(categoryNotifierProvider.notifier)
                      .updateCategory(newValue);
                }
              },
            ),

            SizedBox(height: 10),

            if (categoryState.isCustomSelected)
              TextField(
                controller: _textEditingController1,
                decoration: InputDecoration(
                  hintText: 'Enter Custom Category',
                  border: OutlineInputBorder(),
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
                    category: categoryState.isCustomSelected
                        ? _textEditingController1.text
                        : categoryState.selectedcategory,
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
