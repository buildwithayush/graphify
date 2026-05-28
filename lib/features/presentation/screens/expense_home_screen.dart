import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/core/constant/colors.dart';
import 'package:graphify/features/data/models/expense.dart';
import 'package:graphify/features/data/providers/expense_repository_provider.dart';
import 'package:graphify/features/presentation/providers/category_provider.dart';
import 'package:graphify/features/presentation/providers/expenses.dart';
import 'package:graphify/features/presentation/screens/expense_chart_screen.dart';
import 'package:graphify/features/presentation/screens/expense_view.dart';
import 'package:graphify/features/presentation/widgets/Tdate_time_picker.dart';
import 'package:graphify/features/settings/presentation/screens/settings_screen.dart';

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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
    
        title: Text('Graphify', style: theme.textTheme.titleLarge),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
            
              icon: const Icon(Icons.settings),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add Your Expenses', style: theme.textTheme.titleMedium),
            const SizedBox(height: 16),

            // Big Main Container Card
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
               
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: theme.colorScheme.outline.withOpacity(0.15), 
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(theme.brightness == Brightness.dark ? 0.25 : 0.02),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
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

                  Text('Category', style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 8),

                  // Dropdown Container Wrapper 
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.inputDecorationTheme.fillColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: theme.brightness == Brightness.dark 
                            ? const Color(0xFF334155) 
                            : const Color(0xFFE5E7EB),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: categoryState.selectedcategory,
                        isExpanded: true,
                        dropdownColor: theme.cardColor, 
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: theme.brightness == Brightness.dark 
                              ? Colors.white70 
                              : const Color(0xFF4B5563),
                        ),
                        items: categories.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item, style: theme.textTheme.bodyLarge),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            ref.read(categoryNotifierProvider.notifier).updateCategory(newValue);
                          }
                        },
                      ),
                    ),
                  ),

                  if (categoryState.isCustomSelected) ...[
                    const SizedBox(height: 16),
                    TextField(
                      controller: _textEditingController1,
                      
                      decoration: const InputDecoration(
                        hintText: 'Enter Custom Category',
                      ),
                    ),
                  ],

                  const SizedBox(height: 20),
                  Text('Amount', style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 8),

                  // Amount TextField
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _textEditingController2,
                    style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                    decoration: const InputDecoration(
                      hintText: '0.00',
                      prefixIcon: Icon(Icons.currency_rupee, size: 18),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Add Expense
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary, 
                        foregroundColor: theme.brightness == Brightness.dark ? Colors.black : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        final repo = await ref.read(
                          expenseRepositoryProvider.future,
                        );

                        final expense = Expense(
                          category: categoryState.isCustomSelected
                              ? _textEditingController1.text
                              : categoryState.selectedcategory,
                          amount:
                              double.tryParse(_textEditingController2.text) ??
                              0.0,
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: const Color(0xFF10B981), 
                            ),
                          );
                        }
                      },
                      child:  Text(
                        'Add Expense',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ExpenseView(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.bar_chart_rounded, size: 18),
                    label: const Text('Charts'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ExpenseChartScreen(),
                        ),
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