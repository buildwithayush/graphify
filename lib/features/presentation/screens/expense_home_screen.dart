import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/features/data/models/expense.dart';
import 'package:graphify/features/data/providers/expense_repository_provider.dart';
import 'package:graphify/features/presentation/screens/expense_view.dart';


class ExpenseHomeScreen extends ConsumerStatefulWidget {
  const ExpenseHomeScreen({super.key});

  @override
  ConsumerState<ExpenseHomeScreen> createState() => _ExpenseHomeScreenState();
}

TextEditingController _textEditingController1 = TextEditingController();
TextEditingController _textEditingController2 = TextEditingController();

class _ExpenseHomeScreenState extends ConsumerState<ExpenseHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expenses')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Add Your Expenses'),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.greenAccent,
              ),
              child: TextFormField(
                controller: _textEditingController1,
                style: TextStyle(backgroundColor: Colors.blue),
              ),
            ),
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.blueGrey,
              ),
              child: TextFormField(
                controller: _textEditingController2,
                style: TextStyle(backgroundColor: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () async {
                  final repo = ref.read(expenseRepositoryProvider);
                  
                    final expense = Expense(
                      category: _textEditingController1.text,
                      amount:
                          double.tryParse(_textEditingController2.text) ?? 0.0,
                    );
        
                  await repo.addExpense(expense);
                },
                child: Text('Add Expense'),
              ),
        
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ExpenseView()));
            }, child: Text('Neext Screen'))
          ],
        ),
      ),
     
    );
  }
}
