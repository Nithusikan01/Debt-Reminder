import 'package:drift/drift.dart';

import '../../core/constants/currency_presets.dart';
import '../local/database.dart';

class SettingsRepository {
  final AppDatabase _db;

  SettingsRepository(this._db);

  Stream<String> watchCurrencyCode() {
    return _db.select(_db.appSettings).watchSingleOrNull().map(
          (row) => row?.currencyCode ?? defaultCurrencyCode,
        );
  }

  Future<String> getCurrencyCode() async {
    final row =
        await _db.select(_db.appSettings).getSingleOrNull();
    return row?.currencyCode ?? defaultCurrencyCode;
  }

  Future<void> setCurrencyCode(String currencyCode) async {
    await _db.into(_db.appSettings).insertOnConflictUpdate(
          AppSettingsCompanion.insert(
            id: const Value(0),
            currencyCode: Value(currencyCode),
          ),
        );
  }
}
