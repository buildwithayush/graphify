import 'package:isar/isar.dart';

part 'expense.g.dart';

@collection
class Expense {
  Id id = Isar.autoIncrement;

  @Index() 
  DateTime? date;

  double? amount;

  
  @Index(type: IndexType.value)
  String category = '';

  
  Expense({this.date, this.amount,  this.category = ''});
}