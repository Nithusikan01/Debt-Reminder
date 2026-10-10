import 'package:drift/drift.dart';

import '../../../core/enums/debt_kind.dart';
import '../../../core/enums/reminder_offset.dart';

/// Bookkeeping row for one scheduled `flutter_local_notifications` alarm, so
/// it can be cancelled precisely on edit, delete, or early payment without
/// recomputing which notifications exist.
@DataClassName('ScheduledNotificationRow')
class ScheduledNotifications extends Table {
  IntColumn get notificationId => integer()();
  TextColumn get debtType => textEnum<DebtKind>()();
  TextColumn get referenceId => text()();
  TextColumn get offsetLabel => textEnum<ReminderOffset>()();
  DateTimeColumn get scheduledFor => dateTime()();

  @override
  Set<Column> get primaryKey => {notificationId};
}
