import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/notification_reconciler.dart';
import '../domain/reminder_scheduler.dart';
import 'local/database.dart';
import 'notifications/notification_service.dart';
import 'repositories/dashboard_repository.dart';
import 'repositories/one_time_debt_repository.dart';
import 'repositories/price_code_repository.dart';
import 'repositories/recurring_debt_repository.dart';
import 'repositories/settings_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return FlutterNotificationService();
});

final reminderSchedulerProvider = Provider<ReminderScheduler>((ref) {
  return ReminderScheduler(
    ref.watch(notificationServiceProvider),
    ref.watch(appDatabaseProvider),
  );
});

final oneTimeDebtRepositoryProvider = Provider<OneTimeDebtRepository>((ref) {
  return OneTimeDebtRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(reminderSchedulerProvider),
  );
});

final recurringDebtRepositoryProvider = Provider<RecurringDebtRepository>((ref) {
  return RecurringDebtRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(reminderSchedulerProvider),
  );
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(ref.watch(appDatabaseProvider));
});

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository(
    ref.watch(oneTimeDebtRepositoryProvider),
    ref.watch(recurringDebtRepositoryProvider),
  );
});

final currencyCodeProvider = StreamProvider<String>((ref) {
  return ref.watch(settingsRepositoryProvider).watchCurrencyCode();
});

final priceCodeRepositoryProvider = Provider<PriceCodeRepository>((ref) {
  return PriceCodeRepository(ref.watch(appDatabaseProvider));
});

final priceCodeGroupsProvider = StreamProvider<List<PriceCodeDigitGroup>>((ref) {
  return ref.watch(priceCodeRepositoryProvider).watchGroupedByDigit();
});

final notificationReconcilerProvider = Provider<NotificationReconciler>((ref) {
  return NotificationReconciler(
    ref.watch(oneTimeDebtRepositoryProvider),
    ref.watch(recurringDebtRepositoryProvider),
    ref.watch(settingsRepositoryProvider),
    ref.watch(reminderSchedulerProvider),
  );
});
