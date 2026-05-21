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
      backgroundColor: const Color(0xFFF8F9FA), 
      appBar: AppBar(
        title: const Text(
          'Graphify',
          style: TextStyle(
            color: Color(0xFF0F172A), 
            fontWeight: FontWeight.bold, 
            fontSize: 22,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Your Expenses',
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w600, 
                color: Color(0xFF4B5563),
              ),
            ),
            const SizedBox(height: 16),
            
          \
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // DateTime picker
                  TdateTimePicker(
                    onDateSelected: (selectedDate) {
                      expenseDate = selectedDate;
                      ref.invalidate(expensesProvider);
                    },
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 13, 
                      fontWeight: FontWeight.w600, 
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 8),

                \
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: categoryState.selectedcategory,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF4B5563)),
                        items: categories.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item, 
                            child: Text(
                              item, 
                              style: const TextStyle(fontSize: 15, color: Color(0xFF1F2937)),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            ref
                                .read(categoryNotifierProvider.notifier)
                                .updateCategory(newValue);
                          }
                        },
                      ),
                    ),
                  ),

                  if (categoryState.isCustomSelected) ...[
                    const SizedBox(height: 16),
                    TextField(
                      controller: _textEditingController1,
                      decoration: InputDecoration(
                        hintText: 'Enter Custom Category',
                        hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                        filled: true,
                        fillColor: const Color(0xFFF9FAFB),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 1.5),
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 20),
                  const Text(
                    'Amount',
                    style: TextStyle(
                      fontSize: 13, 
                      fontWeight: FontWeight.w600, 
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Amount TextField
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _textEditingController2,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: '0.00',
                      hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 16),
                      prefixIcon: const Icon(Icons.currency_rupee, size: 18, color: Color(0xFF4B5563)),
                      filled: true,
                      fillColor: const Color(0xFFF9FAFB),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Primary Action Button: Add Expense
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F172A),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        final repo = await ref.read(expenseRepositoryProvider.future);

                        final expense = Expense(
                          category: categoryState.isCustomSelected
                              ? _textEditingController1.text
                              : categoryState.selectedcategory,
                          amount: double.tryParse(_textEditingController2.text) ?? 0.0,
                          date: expenseDate,
                        );

                        await repo.addExpense(expense);
                        ref.invalidate(expensesProvider);
                        _textEditingController1.clear();
                        _textEditingController2.clear();
                        
                       
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Expense added successfully'),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              backgroundColor: const Color(0xFF10B981),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Add Expense',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

           
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.list_alt_rounded, size: 18),
                    label: const Text('All Expenses'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF374151),
                      side: const BorderSide(color: Color(0xFFD1D5DB), width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ExpenseView()),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.bar_chart_rounded, size: 18),
                    label: const Text('Charts'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF374151),
                      side: const BorderSide(color: Color(0xFFD1D5DB), width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ExpenseChartScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}