import 'package:clock/clock.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:debt_reminder/core/enums/debt_kind.dart';
import 'package:debt_reminder/core/enums/reminder_offset.dart';
import 'package:debt_reminder/data/local/database.dart';
import 'package:debt_reminder/data/notifications/notification_service.dart';
import 'package:debt_reminder/domain/reminder_scheduler.dart';

class FakeNotificationService implements NotificationService {
  final List<int> scheduledIds = [];
  final List<int> cancelledIds = [];

  @override
  Future<void> init({required void Function(String? payload) onNotificationTap}) async {}

  @override
  Future<void> requestPermissions() async {}

  @override
  Future<void> schedule({
    required int notificationId,
    required String title,
    required String body,
    required DateTime scheduledFor,
    required String payload,
  }) async {
    scheduledIds.add(notificationId);
  }

  @override
  Future<void> cancel(int notificationId) async {
    cancelledIds.add(notificationId);
  }

  @override
  Future<void> cancelAll(Iterable<int> notificationIds) async {
    cancelledIds.addAll(notificationIds);
  }
}

void main() {
  late AppDatabase db;
  late FakeNotificationService notificationService;
  late ReminderScheduler scheduler;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    notificationService = FakeNotificationService();
    scheduler = ReminderScheduler(notificationService, db);
  });

  tearDown(() async {
    await db.close();
  });

  test('schedules all 4 offsets when due date is far in the future', () async {
    await withClock(Clock.fixed(DateTime(2026, 9, 1)), () async {
      await scheduler.scheduleFor(
        kind: DebtKind.oneTime,
        referenceId: 'debt-1',
        dueDate: DateTime(2026, 9, 20),
        amount: 1000,
        payee: 'Landlord',
        currencyCode: 'LKR',
      );
    });

    expect(notificationService.scheduledIds.length, ReminderOffset.values.length);
  });

  test('skips offsets whose target time has already passed', () async {
    // Due 2026-09-20: the 7-day (09-13) and 5-day (09-15) reminders are
    // already in the past relative to "now"; only 3-day (09-17) and
    // 1-day (09-19) are still ahead and should be scheduled.
    await withClock(Clock.fixed(DateTime(2026, 9, 16, 10)), () async {
      await scheduler.scheduleFor(
        kind: DebtKind.oneTime,
        referenceId: 'debt-2',
        dueDate: DateTime(2026, 9, 20),
        amount: 500,
        payee: 'Electric Co',
        currencyCode: 'LKR',
      );
    });

    expect(notificationService.scheduledIds.length, 2);
  });

  test('cancelAllFor cancels every notification recorded for a reference', () async {
    await withClock(Clock.fixed(DateTime(2026, 9, 1)), () async {
      await scheduler.scheduleFor(
        kind: DebtKind.oneTime,
        referenceId: 'debt-3',
        dueDate: DateTime(2026, 9, 20),
        amount: 500,
        payee: 'Electric Co',
        currencyCode: 'LKR',
      );
    });

    await scheduler.cancelAllFor('debt-3');

    expect(notificationService.cancelledIds.length, ReminderOffset.values.length);
  });
}
