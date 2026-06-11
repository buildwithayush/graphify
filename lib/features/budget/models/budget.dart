import 'package:isar/isar.dart';

part 'budget.g.dart';

@collection
class Budget {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late int period;

  late double amount;
}
