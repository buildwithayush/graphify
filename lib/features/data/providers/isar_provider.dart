import 'package:graphify/features/data/models/expense.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

part 'isar_provider.g.dart';

@riverpod
Future<Isar> isar(IsarRef ref) async {
  final existingIsar = Isar.getInstance();

  if (existingIsar != null && existingIsar.isOpen) {
    return existingIsar;
  }

  final dir = await getApplicationDocumentsDirectory();

  return await Isar.open([ExpenseSchema], directory: dir.path);
}
