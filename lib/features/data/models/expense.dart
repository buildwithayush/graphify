import 'package:isar/isar.dart';

part 'expense.g.dart';

@collection
class Expense {
  Id id ;

  @Index() 
  DateTime date;

  double amount;

  
  @Index(type: IndexType.value)
  String category = '';

  
  Expense({ this.id = Isar.autoIncrement, required this.date, required this.amount ,  this.category = ''});
}