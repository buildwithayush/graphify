import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:graphify/features/presentation/screens/expense_home_screen.dart';
import 'package:graphify/main.dart';
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
      throw Exception('Localization Error');
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

  Future<void> showInstantRecurringNotification({
    required int id,
    required String category,
    required double amount,
  }) async {
    final String payloadData = "$category|$amount";
    await _notificationsPlugin.show(
      id: id,
      title: '💸 Auto Expense Logged!',
      body: '₹$amount has been automatically added for $category.',
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'recurring_channel_id',
          'Recurring Expenses Alerts',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: payloadData,
    );
  }
}
