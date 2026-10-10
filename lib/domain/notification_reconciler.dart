import '../core/enums/debt_kind.dart';
import '../data/repositories/one_time_debt_repository.dart';
import '../data/repositories/recurring_debt_repository.dart';
import '../data/repositories/settings_repository.dart';
import 'reminder_scheduler.dart';

/// Re-arms every open reminder, in the background after launch. Android
/// drops an app's alarms when it is force-stopped, and the plugin's own
/// "pending" list isn't updated when that happens, so it can't be trusted
/// to tell which alarms are still live. `scheduleFor` is idempotent
/// (deterministic notification ids, already-past offsets are skipped), so
/// re-arming reminders that are still live is harmless.
class NotificationReconciler {
  final OneTimeDebtRepository _oneTimeRepo;
  final RecurringDebtRepository _recurringRepo;
  final SettingsRepository _settingsRepo;
  final ReminderScheduler _scheduler;

  NotificationReconciler(
    this._oneTimeRepo,
    this._recurringRepo,
    this._settingsRepo,
    this._scheduler,
  );

  Future<void> reconcileAll() async {
    final currencyCode = await _settingsRepo.getCurrencyCode();

    final oneTimeDebts = await _oneTimeRepo.watchAll().first;
    for (final debt in oneTimeDebts.where((d) => !d.isPaid)) {
      await _scheduler.scheduleFor(
        kind: DebtKind.oneTime,
        referenceId: debt.id,
        dueDate: debt.dueDate,
        amount: debt.amount,
        payee: debt.payee,
        chequeNumber: debt.chequeNumber,
        currencyCode: currencyCode,
      );
    }

    final openOccurrences = await _recurringRepo.watchAllOpenOccurrences().first;
    for (final item in openOccurrences) {
      await _scheduler.scheduleFor(
        kind: DebtKind.recurringOccurrence,
        referenceId: item.occurrence.id,
        dueDate: item.occurrence.expectedDueDate,
        amount: item.occurrence.amount,
        payee: item.parent.payee,
        currencyCode: currencyCode,
      );
    }
  }
}
