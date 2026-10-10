import 'package:drift/drift.dart';

import 'recurring_debts_table.dart';

/// One payable cycle for a recurring debt. [expectedDueDate] is the
/// scheduling anchor and must never be mutated in response to a late
/// payment — only [paidAt] records when payment actually happened.
@DataClassName('DebtOccurrenceRow')
class DebtOccurrences extends Table {
  TextColumn get id => text()();
  TextColumn get recurringDebtId =>
      text().references(RecurringDebts, #id)();
  DateTimeColumn get expectedDueDate => dateTime()();
  RealColumn get amount => real()();
  BoolColumn get isPaid => boolean().withDefault(const Constant(false))();
  DateTimeColumn get paidAt => dateTime().nullable()();
  IntColumn get cycleIndex => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
