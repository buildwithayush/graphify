import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/core/themes/providers/theme_provider.dart';
import 'package:graphify/core/themes/themes.dart';
import 'package:graphify/features/budget/models/budget.dart';
import 'package:graphify/features/data/models/expense.dart';
import 'package:graphify/features/notifications/data/notification_service.dart';
import 'package:graphify/features/presentation/screens/expense_home_screen.dart';
import 'package:graphify/features/recurring_expenses/domain/models/recurring_model.dart';
import 'package:graphify/features/report_analytics/data/models/monthly_report_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

late final Isar globalsar;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.init();
  await NotificationService.scheduleDaily8PMReminder();
  
 final dir = await getApplicationDocumentsDirectory();

 globalsar = await Isar.open(
  [ExpenseSchema, BudgetSchema, MonthlyReportSchema,RecurringModelSchema],
  directory: dir.path);

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    return MaterialApp(
      navigatorKey: globalKey,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      home: const ExpenseHomeScreen(),
      title: 'Graphify',
    );
  }
}

final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
