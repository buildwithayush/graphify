
import 'package:graphify/features/expenses/enums/expense_filter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_filter.g.dart';

@riverpod
class ExpenseFilterNotifier extends _$ExpenseFilterNotifier {
  @override
  ExpenseFilter build(){
    return ExpenseFilter.today;
  }

  void changeFilter(ExpenseFilter filter){
    state = filter;
  }
}