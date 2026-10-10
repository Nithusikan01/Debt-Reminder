import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:debt_reminder/core/enums/frequency_type.dart';
import 'package:debt_reminder/data/local/database.dart';
import 'package:debt_reminder/data/notifications/notification_service.dart';
import 'package:debt_reminder/data/repositories/recurring_debt_repository.dart';
import 'package:debt_reminder/domain/reminder_scheduler.dart';

class NoopNotificationService implements NotificationService {
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
  }) async {}

  @override
  Future<void> cancel(int notificationId) async {}

  @override
  Future<void> cancelAll(Iterable<int> notificationIds) async {}
}

void main() {
  late AppDatabase db;
  late RecurringDebtRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    final scheduler = ReminderScheduler(NoopNotificationService(), db);
    repo = RecurringDebtRepository(db, scheduler);
  });

  tearDown(() async {
    await db.close();
  });

  test('marking an occurrence paid generates the next one from the expected date, not the paid date', () async {
    final debtId = await withClock(Clock.fixed(DateTime(2026, 8, 1)), () async {
      return repo.create(
        title: 'Shop Rent',
        payee: 'Landlord',
        defaultAmount: 15000,
        frequencyType: FrequencyType.monthlyOnDay,
        dayOfMonth: 5,
        anchorDate: DateTime(2026, 9, 5),
        currencyCode: 'LKR',
      );
    });

    final firstOccurrence = await (db.select(db.debtOccurrences)
          ..where((t) => t.recurringDebtId.equals(debtId)))
        .getSingle();
    expect(firstOccurrence.expectedDueDate, DateTime(2026, 9, 5));

    // Paid late, on the 9th - four days after the expected due date.
    await withClock(Clock.fixed(DateTime(2026, 9, 9)), () async {
      await repo.markOccurrencePaid(firstOccurrence.id, currencyCode: 'LKR');
    });

    final allOccurrences = await (db.select(db.debtOccurrences)
          ..where((t) => t.recurringDebtId.equals(debtId)))
        .get();
    expect(allOccurrences.length, 2);

    final nextOccurrence = allOccurrences.firstWhere((o) => o.id != firstOccurrence.id);
    // Next due date is the 5th of next month, derived from the expected
    // date (Sep 5), not the paid date (Sep 9).
    expect(nextOccurrence.expectedDueDate, DateTime(2026, 10, 5));
    expect(nextOccurrence.cycleIndex, 1);
  });

  test('exactly one open occurrence exists per recurring debt at a time', () async {
    final debtId = await withClock(Clock.fixed(DateTime(2026, 1, 1)), () async {
      return repo.create(
        title: 'Daily Chit',
        payee: 'Chit Group',
        defaultAmount: 200,
        frequencyType: FrequencyType.daily,
        anchorDate: DateTime(2026, 1, 2),
        currencyCode: 'LKR',
      );
    });

    final openBefore = await (db.select(db.debtOccurrences)
          ..where((t) => t.recurringDebtId.equals(debtId) & t.isPaid.equals(false)))
        .get();
    expect(openBefore.length, 1);

    await withClock(Clock.fixed(DateTime(2026, 1, 2)), () async {
      await repo.markOccurrencePaid(openBefore.single.id, currencyCode: 'LKR');
    });

    final openAfter = await (db.select(db.debtOccurrences)
          ..where((t) => t.recurringDebtId.equals(debtId) & t.isPaid.equals(false)))
        .get();
    expect(openAfter.length, 1);
    expect(openAfter.single.expectedDueDate, DateTime(2026, 1, 3));
  });
}
