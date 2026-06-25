import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/features/presentation/providers/category_provider.dart';
import 'package:graphify/features/presentation/providers/expense_notifier.dart';
import 'package:graphify/features/presentation/providers/expenses.dart';
import 'package:graphify/features/receipt_scanner/domain/models/parsed_recipt.dart';
import 'package:graphify/features/receipt_scanner/presentation/providers/receipt_scanner_provider.dart';
import 'package:graphify/features/receipt_scanner/presentation/widgets/receipt_review_dialog.dart';
import 'package:graphify/features/recurring_expenses/domain/models/recurring_model.dart';
import 'package:graphify/features/recurring_expenses/presentation/providers/recurring_provider.dart';
import 'package:graphify/features/recurring_expenses/presentation/widgets/recurring_tick_box.dart';
import 'package:graphify/features/recurring_expenses/presentation/widgets/short_month_validator.dart';
import 'package:graphify/features/report_analytics/presentation/screens/expense_chart_screen.dart';
import 'package:graphify/features/presentation/screens/expense_view.dart';
import 'package:graphify/features/presentation/screens/expenses_card_screen.dart';
import 'package:graphify/features/presentation/widgets/Tdate_time_picker.dart';
import 'package:graphify/features/report_analytics/presentation/screens/report_analytics_screen.dart';
import 'package:graphify/features/settings/presentation/screens/settings_screen.dart';
import 'package:image_picker/image_picker.dart';

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
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
void initState() {
  super.initState();
  
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ref.read(recurringControllerProvider.notifier).checkAndLogPendingRecurringExpenses();
  });
}

  @override
  void dispose() {
    categoryController.dispose();
    amountController.dispose();
    super.dispose();
  }

  DateTime expenseDate = DateTime.now();
  bool isCustomSelected = false;
  bool isTickChecked = false;

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<ParsedReceipt?>>(receiptScannerControllerProvider, (
      prev,
      next,
    ) {
      next.when(
        data: (parsedReceipt) {
          if (parsedReceipt != null) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (dialogContext) =>
                  ReceiptReviewDialog(parsedData: parsedReceipt),
            );
          }
        },
        error: (err, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '⚠️ Processing Error: ${err.toString().replaceAll('Exception: ', '')}',
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        loading: () {},
      );
    });
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
                  color: theme.colorScheme.outline.withValues(alpha: 0.15),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: theme.brightness == Brightness.dark ? 0.25 : 0.02,
                    ),
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
                      controller: categoryController,

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
                    controller: amountController,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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
                        backgroundColor: theme.brightness == Brightness.dark
                            ? Colors.black
                            : Colors.blueGrey,
                        foregroundColor: theme.brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        final String finalCategory =
                            categoryState.isCustomSelected
                            ? categoryController.text.trim()
                            : categoryState.selectedcategory;

                        final double finalAmount =
                            double.tryParse(amountController.text) ?? 0.0;

                        //  CORE SYSTEM DIRECTION CONTROLLER
                        if (isTickChecked) {
                          final int safeRecurringDay = expenseDate.day > 28
                              ? 28
                              : expenseDate.day;
                          final newRule = RecurringModel(
                            category: finalCategory,
                            amount: finalAmount,
                            recurringDay: safeRecurringDay,

                            lastLoggedDate: DateTime(
                              expenseDate.year,
                              expenseDate.month,
                              safeRecurringDay,
                            ),
                          );
                          await ref
                              .read(recurringControllerProvider.notifier)
                              .addRecurringRule(newRule);

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "🔄 Monthly automation active for $finalCategory!",
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: const Color.fromARGB(255, 117, 169, 253),
                              ),
                            );
                          }
                        }

                        final expenseNotifier = ref.read(
                          expenseNotifierProvider.notifier,
                        );
                        await expenseNotifier.handleAddExpense(
                          category: categoryState.isCustomSelected
                              ? categoryController.text
                              : categoryState.selectedcategory,
                          amount: amountController.text,
                          selectedDate: expenseDate,
                        );
                        ref.invalidate(expensesProvider);

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("💸 Expense logged successfully!"),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          // FORM RESET 
                          setState(() {
                            amountController.clear();
                            categoryController.clear();
                            isTickChecked = false;
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add Expense',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RecurringTickBox(
                                value: isTickChecked,
                                onChanged: (value) {
                                  setState(() {
                                    isTickChecked = value ?? false;
                                  });
                                },
                                selectedDate: expenseDate,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  ShortMonthValidator(
                    value: isTickChecked,
                    selectedDate: expenseDate,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            //  SCAN BILL ELEVATED BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.brightness == Brightness.dark
                        ? Colors.black
                        : Colors.blueGrey,
                    foregroundColor: theme.brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),

                  onPressed:
                      ref.watch(receiptScannerControllerProvider).isLoading
                      ? null
                      : () {
                          _showSourceSelectorSheet(context, ref);
                        },
                  child: ref.watch(receiptScannerControllerProvider).isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.qr_code_scanner_rounded, size: 20),
                            SizedBox(width: 10),
                            Text(
                              'Scan Receipt with OCR',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ExpenseHomeScreen();
                    },
                  ),
                );
              },
              icon: Icon(Icons.home),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ExpenseView();
                    },
                  ),
                );
              },
              icon: Icon(Icons.list_alt),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ExpensesCardScreen();
                    },
                  ),
                );
              },
              icon: Icon(Icons.currency_rupee),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ReportAnalyticsScreen();
                    },
                  ),
                );
              },
              icon: Icon(Icons.analytics),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ExpenseChartScreen();
                    },
                  ),
                );
              },
              icon: Icon(Icons.add_chart),
            ),
          ],
        ),
      ),
    );
  }

  void _showSourceSelectorSheet(BuildContext parentContext, WidgetRef ref) {
    showModalBottomSheet(
      context: parentContext,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        final colorScheme = Theme.of(sheetContext).colorScheme;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Text(
                  "Select Receipt Source",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // LIVE CAMERA PHOTO
                ListTile(
                  leading: Icon(
                    Icons.camera_alt_rounded,
                    color: colorScheme.primary,
                  ),
                  title: const Text(
                    "Take Live Photo (Camera)",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  onTap: () async {
                    Navigator.pop(sheetContext);

                    // SAFE MOUNTED CHECK
                    if (!parentContext.mounted) return;

                    await ref
                        .read(receiptScannerControllerProvider.notifier)
                        .scanReceipt(
                          source: ImageSource.camera,
                          context: parentContext,
                        );
                  },
                ),

                //  CHOOSE FROM GALLERY
                ListTile(
                  leading: Icon(
                    Icons.image_rounded,
                    color: colorScheme.primary,
                  ),
                  title: const Text(
                    "Choose from Gallery",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  onTap: () async {
                    Navigator.pop(sheetContext);

                    // Safe layout check
                    if (!parentContext.mounted) return;

                    // 3. Gallery
                    await ref
                        .read(receiptScannerControllerProvider.notifier)
                        .scanReceipt(
                          source: ImageSource.gallery,
                          context: parentContext,
                        );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
