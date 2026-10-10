import 'package:drift/drift.dart';

import '../../../core/constants/currency_presets.dart';

/// Single-row table (id is always 0) holding app-wide settings.
@DataClassName('AppSettingRow')
class AppSettings extends Table {
  IntColumn get id => integer().withDefault(const Constant(0))();
  TextColumn get currencyCode =>
      text().withDefault(const Constant(defaultCurrencyCode))();

  @override
  Set<Column> get primaryKey => {id};
}
