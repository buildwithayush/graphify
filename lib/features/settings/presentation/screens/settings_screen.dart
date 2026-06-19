import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/core/themes/providers/theme_provider.dart';
import 'package:graphify/features/data/models/expense.dart';
import 'package:graphify/features/presentation/providers/expenses.dart';
import 'package:graphify/features/settings/presentation/providers/expense_export_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _isExporting = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final allExpensesAsync = ref.watch(expensesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Column(
        children: [
          // ─── DARK MODE OPTION ───
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: ref.watch(themeNotifierProvider) == ThemeMode.dark,
            onChanged: (value) {
              ref.read(themeNotifierProvider.notifier).toggleTheme(value);
            },
          ),

          // ─── EXPORT EXPENSES OPTION ───
          ListTile(
            title: const Text("Export Expenses"),
            trailing: _isExporting
                ? SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: colorScheme.primary),
                  )
                : const Icon(Icons.chevron_right_rounded),
            onTap: _isExporting
                ? null
                : () {
                    allExpensesAsync.whenData((expenses) {
                      if (expenses.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("⚠️ No expense records found to export!")),
                        );
                        return;
                      }
                      _showExportPeriodDialog(context, expenses);
                    });
                  },
          ),
        ],
      ),
    );
  }

 void _showExportPeriodDialog(BuildContext context, List<Expense> expenses) {
    final options = ["All Time", "Last 7 Days", "Last 30 Days"];

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Select Export Period", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((mode) {
            return SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(alignment: Alignment.centerLeft),
                onPressed: () async {
                  Navigator.pop(dialogContext);
                  
                  setState(() {
                    _isExporting = true;
                  });

                  await Future.delayed(const Duration(milliseconds: 300));

                  final DateTime startTime = DateTime.now();

                  try {
                    await ref.read(expenseExportControllerProvider.notifier).triggerCsvExport(
                          allExpenses: expenses,
                          filterMode: mode,
                        );
                    
                    
                    final DateTime endTime = DateTime.now();
                    final int durationInLines = endTime.difference(startTime).inMilliseconds;

            
                    if (durationInLines > 2000 && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('📊 CSV Report Generated Successfully!')),
                      );
                    }
                  } catch (err) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('❌ Export Failed: $err'), backgroundColor: Colors.red),
                      );
                    }
                  } finally {
                    if (mounted) {
                      setState(() {
                        _isExporting = false;
                      });
                    } else {
                      _isExporting = false;
                    }
                  }
                },
                child: Text(mode, style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
              ),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          )
        ],
      ),
    );
  }}