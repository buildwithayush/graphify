import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:graphify/features/budget/models/budget.dart';
import 'package:graphify/features/data/models/expense.dart';
import 'package:graphify/features/presentation/screens/expense_home_screen.dart';
import 'package:graphify/features/report_analytics/data/models/monthly_report_model.dart';
import 'package:graphify/main.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();

    try {
      tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    } catch (e) {
      // Timezone initialization is safe to fail here because
      // the system defaults to the main initialization backup.
    }

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    if (await Permission.scheduleExactAlarm.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }

    await _notificationsPlugin.initialize(
      settings: settings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          _handleNotificationClick(response.payload!);
        }
      },
    );
  }

  static void _handleNotificationClick(String payload) {
    if (payload == 'expense_remainder') {
      globalKey.currentState?.push(
        MaterialPageRoute(builder: (context) => const ExpenseHomeScreen()),
      );
    }
  }

  static Future<void> scheduleDaily8PMReminder() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'daily_reminder_channel',
          'Daily Reminders',
          channelDescription: 'Reminds you to add your daily expenses',
          importance: Importance.max,
          priority: Priority.high,
        );

    await _notificationsPlugin.zonedSchedule(
      id: 0,
      title: 'Aaj ka expense add kiya? 🤔',
      body: 'Click To Add Todays Expense',
      scheduledDate: _nextInstanceOfEightPM(),

      notificationDetails: const NotificationDetails(android: androidDetails),

      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'expense_remainder',
    );
  }

  static tz.TZDateTime _nextInstanceOfEightPM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      20,
      02,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = now.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  Future<void> scheduleRecurringNotification({
    required int id,
    required String category,
    required double amount,
    required int targetDay,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    // tz.TZDateTime scheduleDate = tz.TZDateTime(
    //   tz.local,
    //   now.year,
    //   now.year,
    //   targetDay,
    //   10,
    //   0,
    // );
    final tz.TZDateTime scheduledDate = tz.TZDateTime.now(
      tz.local,
    ).add(const Duration(minutes: 2));
    // if (scheduledDate.isBefore(now)) {
    //   scheduledDate = tz.TZDateTime(
    //     tz.local,
    //     now.year,
    //     now.month + 1,
    //     targetDay,
    //     10,
    //     0,
    //   );
    // }
    final String payloadData = "$category|$amount";
    debugPrint("🚨 SENDING PAYLOAD: $payloadData");
    await _notificationsPlugin.zonedSchedule(
      id: id,
      title: '🔄 Auto Expense Logged!',
      body: '₹$amount has been automatically added to your $category category.',
      scheduledDate: scheduledDate,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'recurring_channel_id',
          'Recurring Expenses Alerts',
          channelDescription:
              'Notifications for automated fixed monthly expenses',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
      payload: payloadData,
    );
  }

  Future<void> cancelAlarm(int id) async {
    await _notificationsPlugin.cancel(id: id);
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(
  NotificationResponse notificationResponse,
) async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint("🚨 BACKGROUND TRIGGERED VIA OS ALARM!");

  final String? payload = notificationResponse.payload;

  if (payload != null && payload.isNotEmpty) {
    final List<String> dataParts = payload.split('|');
    final String category = dataParts[0];
    final String amountString = dataParts[1];
    final double amount = double.tryParse(amountString) ?? 0.0;

    try {
      Isar? isar = Isar.getInstance();

      if (isar == null) {
        final dir = await getApplicationDocumentsDirectory();

        isar = await Isar.open([
          ExpenseSchema,
          BudgetSchema,
          MonthlyReportSchema,
        ], directory: dir.path);
      }

      final newAutoExpense = Expense(
        category: category,
        amount: amount,
        date: DateTime.now(),
      );

      await isar.writeTxn(() async {
        await isar!.expenses.put(newAutoExpense);
      });
    } catch (e) {
      // Isolate background channel failsafe
    }
  }
}
