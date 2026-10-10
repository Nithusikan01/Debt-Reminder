import 'package:drift/drift.dart';

import '../../../core/enums/frequency_type.dart';

@DataClassName('RecurringDebtRow')
class RecurringDebts extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get payee => text()();
  RealColumn get defaultAmount => real()();
  TextColumn get frequencyType => textEnum<FrequencyType>()();
  IntColumn get intervalDays => integer().nullable()();
  IntColumn get dayOfMonth => integer().nullable()();
  DateTimeColumn get anchorDate => dateTime()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
