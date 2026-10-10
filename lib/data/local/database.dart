import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../core/constants/currency_presets.dart';
import '../../core/enums/debt_kind.dart';
import '../../core/enums/frequency_type.dart';
import '../../core/enums/reminder_offset.dart';
import 'tables/app_settings_table.dart';
import 'tables/debt_occurrences_table.dart';
import 'tables/one_time_debts_table.dart';
import 'tables/price_code_letters_table.dart';
import 'tables/recurring_debts_table.dart';
import 'tables/scheduled_notifications_table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  OneTimeDebts,
  RecurringDebts,
  DebtOccurrences,
  ScheduledNotifications,
  AppSettings,
  PriceCodeLetters,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(priceCodeLetters);
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'debt_reminder.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
