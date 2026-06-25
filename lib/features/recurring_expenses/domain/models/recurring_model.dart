import 'package:isar/isar.dart';

part 'recurring_model.g.dart';
@collection 
class RecurringModel {
  Id id = Isar.autoIncrement;
  final String category;
  final double amount;
  final int recurringDay;

  DateTime? lastLoggedDate;

  RecurringModel({
    required this.category,
    required this.amount,
    required this.recurringDay,
    this.lastLoggedDate,
  });
}
