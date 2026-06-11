import 'package:flutter/material.dart';

void showBudgetBottomSheet(BuildContext context, Function(double) onBudgetSaved) {
  final TextEditingController budgetController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true, 
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)), 
    ),
    builder: (context) {
      return Padding(
        
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set Monthly Budget',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: budgetController,
              keyboardType: TextInputType.number, 
              decoration: const InputDecoration(
                labelText: 'Enter Amount',
                prefixText: '₹ ', 
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, 
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  final amount = double.tryParse(budgetController.text);
                  if (amount != null && amount > 0) {
                    onBudgetSaved(amount); 
                    Navigator.pop(context); 
                  } else {
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a valid amount')),
                    );
                  }
                },
                child: const Text('Save Budget'),
              ),
            ),
          ],
        ),
      );
    },
  );
}