import 'package:clock/clock.dart';
import 'package:drift/drift.dart';

import '../core/enums/debt_kind.dart';
import '../core/enums/reminder_offset.dart';
import '../core/utils/date_formatting.dart';
import '../data/local/database.dart';
import '../data/notifications/notification_id_codec.dart';
import '../data/notifications/notification_service.dart';

/// Owns the single business rule for reminders: every debt (one-time, or a
/// recurring debt's current occurrence) gets up to four local notifications
/// at 5 days, 3 days, 1 day before its due date, and the morning of. Any
/// offset whose target time has already passed is simply skipped rather
/// than firing immediately or scheduled in a stack.
class ReminderScheduler {
  final NotificationService _notificationService;
  final AppDatabase _db;

  ReminderScheduler(this._notificationService, this._db);

  Future<void> scheduleFor({
    required DebtKind kind,
    required String referenceId,
    required DateTime dueDate,
    required double amount,
    required String payee,
    String? chequeNumber,
    required String currencyCode,
  }) async {
    final title = kind == DebtKind.oneTime ? 'Payment due' : 'Recurring payment due';
    final amountText = formatAmount(amount, currencyCode);
    final dateText = formatDueDate(dueDate);
    final chequeText = chequeNumber != null && chequeNumber.isNotEmpty
        ? ' (Cheque #$chequeNumber)'
        : '';
    final body = '$amountText due to $payee on $dateText$chequeText';
    final payload = '${kind == DebtKind.oneTime ? 'onetime' : 'occurrence'}:$referenceId';

    for (final offset in ReminderOffset.values) {
      final scheduledDate = DateTime(
        dueDate.year,
        dueDate.month,
        dueDate.day,
      ).subtract(Duration(days: offset.daysBeforeDue));
      final scheduledFor = DateTime(
        scheduledDate.year,
        scheduledDate.month,
        scheduledDate.day,
        offset.hourOfDay,
      );

      if (scheduledFor.isBefore(clock.now())) {
        continue;
      }

      final notificationId = NotificationIdCodec.encode(referenceId, offset);

      await _notificationService.schedule(
        notificationId: notificationId,
        title: title,
        body: body,
        scheduledFor: scheduledFor,
        payload: payload,
      );

      await _db.into(_db.scheduledNotifications).insertOnConflictUpdate(
            ScheduledNotificationsCompanion.insert(
              notificationId: Value(notificationId),
              debtType: kind,
              referenceId: referenceId,
              offsetLabel: offset,
              scheduledFor: scheduledFor,
            ),
          );
    }
  }

  /// Cancels every not-yet-fired reminder for a debt reference, e.g. when
  /// it's marked paid early, edited, or deleted.
  Future<void> cancelAllFor(String referenceId) async {
    final rows = await (_db.select(_db.scheduledNotifications)
          ..where((t) => t.referenceId.equals(referenceId)))
        .get();

    await _notificationService.cancelAll(rows.map((r) => r.notificationId));

    await (_db.delete(_db.scheduledNotifications)
          ..where((t) => t.referenceId.equals(referenceId)))
        .go();
  }
}
