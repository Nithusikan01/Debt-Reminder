import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// Abstract so `ReminderScheduler` can be unit-tested with a fake, without
/// touching the platform notification channel.
abstract class NotificationService {
  Future<void> init({required void Function(String? payload) onNotificationTap});

  /// Asks for notification / exact-alarm permissions, but only those not
  /// already granted, so nothing is shown on launches after the first.
  Future<void> requestPermissions();

  Future<void> schedule({
    required int notificationId,
    required String title,
    required String body,
    required DateTime scheduledFor,
    required String payload,
  });

  Future<void> cancel(int notificationId);

  Future<void> cancelAll(Iterable<int> notificationIds);
}

/// Thin wrapper around `flutter_local_notifications`. Owns plugin
/// initialization, timezone setup, and the low-level schedule/cancel calls.
/// Business rules (which offsets to schedule, notification text) live in
/// `domain/reminder_scheduler.dart`.
class FlutterNotificationService implements NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const _channelId = 'debt_reminders';
  static const _channelName = 'Debt Reminders';
  static const _channelDescription =
      'Reminders for upcoming and overdue payments';

  /// `init` runs after the first frame, so a debt saved very quickly after
  /// launch must wait for the timezone and plugin setup before scheduling.
  final Completer<void> _ready = Completer<void>();

  @override
  Future<void> init({
    required void Function(String? payload) onNotificationTap,
  }) async {
    try {
      await _initialize(onNotificationTap);
      _ready.complete();
    } catch (e, st) {
      _ready.completeError(e, st);
      rethrow;
    }
  }

  Future<void> _initialize(void Function(String? payload) onNotificationTap) async {
    tz_data.initializeTimeZones();
    final localTimezone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(localTimezone));

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        onNotificationTap(response.payload);
      },
    );
  }

  @override
  Future<void> requestPermissions() async {
    await _ready.future;
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android == null) return;

    if (await android.areNotificationsEnabled() != true) {
      await android.requestNotificationsPermission();
    }
    if (await android.canScheduleExactNotifications() != true) {
      await android.requestExactAlarmsPermission();
    }
  }

  @override
  Future<void> schedule({
    required int notificationId,
    required String title,
    required String body,
    required DateTime scheduledFor,
    required String payload,
  }) async {
    await _ready.future;
    final scheduledTz = tz.TZDateTime.from(scheduledFor, tz.local);
    if (scheduledTz.isBefore(tz.TZDateTime.now(tz.local))) {
      return;
    }

    await _plugin.zonedSchedule(
      notificationId,
      title,
      body,
      scheduledTz,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDescription,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  @override
  Future<void> cancel(int notificationId) async {
    await _ready.future;
    await _plugin.cancel(notificationId);
  }

  @override
  Future<void> cancelAll(Iterable<int> notificationIds) async {
    await _ready.future;
    for (final id in notificationIds) {
      await _plugin.cancel(id);
    }
  }
}
