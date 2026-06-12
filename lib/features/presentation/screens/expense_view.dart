import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/features/data/providers/expense_filter.dart';
import 'package:graphify/features/data/providers/expense_repository_provider.dart';
import 'package:graphify/features/data/providers/filtered_expenses.dart';
import 'package:graphify/features/data/providers/search_query.dart';
import 'package:graphify/features/expenses/enums/expense_filter.dart';

class ExpenseView extends ConsumerStatefulWidget {
  const ExpenseView({super.key});

  @override
  ConsumerState<ExpenseView> createState() => _ExpenseViewState();
}

class _ExpenseViewState extends ConsumerState<ExpenseView> {

TextEditingController searchController = TextEditingController();

List<DropdownMenuItem<ExpenseFilter>> dropitems =[
  DropdownMenuItem(
    value: ExpenseFilter.today,
    child: Text('Today')),
     DropdownMenuItem(
    value: ExpenseFilter.week,
    child: Text('This Week')),
     DropdownMenuItem(
    value: ExpenseFilter.month,
    child: Text('This Month')),
     DropdownMenuItem(
    value: ExpenseFilter.year,
    child: Text('This Year')),
     DropdownMenuItem(
    value: ExpenseFilter.alltime,
    child: Text('All Time')),
] ;

 
  String _formatDate(DateTime? date) {
    if (date == null) return 'No Date';
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final day = date.day.toString().padLeft(2, '0');
    final month = months[date.month - 1];
    final year = date.year;
    return '$day $month, $year';
  }

  // Categories
  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.restaurant_rounded;
      case 'study':
        return Icons.book_rounded;
      case 'utilities':
        return Icons.electric_bolt_rounded;
      case 'transportation':
        return Icons.directions_car_rounded;
      case 'insurance':
        return Icons.shield_rounded;
      default:
        return Icons.local_offer_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final expensesAsync = ref.watch(filteredExpensesProvider);
    final searchQuery = ref.watch(searchQueryProvider);
   
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, 
      appBar: AppBar(
        centerTitle: true,
        title: Text('All Expenses', style: theme.textTheme.titleLarge),
        
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            const SizedBox(height: 10),
             
           Row(
            children: [
               Text('Transaction History', style: theme.textTheme.titleMedium),
               Spacer(),
               DropdownButton<ExpenseFilter>(
                value: ref.watch(expenseFilterNotifierProvider),
                items: dropitems, onChanged:(ExpenseFilter? filter){
                   ref.read(expenseFilterNotifierProvider.notifier).changeFilter(filter!);
               } )
            ],
           ),
            const SizedBox(height: 14),
           TextFormField(
              controller: searchController,
              decoration:  InputDecoration(
              hintText: 'Search Category',
               prefixIcon: Icon(Icons.search),
               suffixIcon: searchQuery.isNotEmpty? IconButton(onPressed: (){
                searchController.clear();
                ref.read(searchQueryProvider.notifier).clear();
               }, icon: Icon(Icons.clear)) : null ,
                 border: OutlineInputBorder(),
                 ),
                 onChanged: (value) {
                   ref.read(searchQueryProvider.notifier).update(value);
                 },
                   ),
             const SizedBox(height: 14),
            Expanded(
              child: expensesAsync.when(
                data: (expenses) {
                  if (expenses.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long_rounded, 
                            size: 64, 
                            color: theme.brightness == Brightness.dark ? Colors.white24 : Colors.grey[300],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No expenses added yet',
                            style: TextStyle(
                              color: theme.brightness == Brightness.dark ? Colors.white54 : Colors.grey[500], 
                              fontSize: 15, 
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: expenses.length,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final expense = expenses[index];

                      return Dismissible(
                        key: Key(expense.id.toString()),
                        direction: DismissDirection.endToStart,
                        dismissThresholds: const {
                          DismissDirection.endToStart : 0.7
                        },background: Container(
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF4444),

                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.delete_rounded,color: Colors.white,size: 24,),
                        ),
                        onDismissed: (direction) async {
                                  final repo = await ref.watch(expenseRepositoryProvider.future);
                                 await  repo.deleteExpense(expense.id);
                             if (context.mounted) {
                               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                               content: Text('Expense deleted successfully'),
                                       duration: Duration(seconds: 2),
                               ));
                             }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: theme.cardColor, 
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: theme.colorScheme.outline.withOpacity(0.15), 
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(theme.brightness == Brightness.dark ? 0.2 : 0.015),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                             
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: theme.brightness == Brightness.dark 
                                      ? const Color(0xFF334155) 
                                      : const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                  child: Icon(
                                  _getCategoryIcon(expense.category),
                                  color: theme.brightness == Brightness.dark 
                                      ? Colors.white70 
                                      : const Color(0xFF475569),
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 16),
                        
                              // Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      expense.category,
                                      style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _formatDate(expense.date),
                                      style: TextStyle(
                                        fontSize: 12, 
                                        color: theme.brightness == Brightness.dark ? Colors.white60 : const Color(0xFF94A3B8),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        
                              // Amount Text
                              Text(
                                '₹${expense.amount}',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 8),
                                     
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => Center(
                  child: CircularProgressIndicator(
                    color: theme.colorScheme.primary, 
                  ),
                ),
                error: (error, stack) => Center(
                  child: Text(
                    error.toString(),
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}