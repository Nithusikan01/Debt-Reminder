import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/enums/debt_kind.dart';
import '../../core/enums/frequency_type.dart';
import '../../core/utils/next_due_date_calculator.dart';
import '../../domain/models/debt_occurrence.dart';
import '../../domain/models/recurring_debt.dart';
import '../../domain/reminder_scheduler.dart';
import '../local/database.dart';

class RecurringDebtRepository {
  final AppDatabase _db;
  final ReminderScheduler _scheduler;

  RecurringDebtRepository(this._db, this._scheduler);

  Stream<List<RecurringDebt>> watchActive() {
    return (_db.select(_db.recurringDebts)
          ..where((t) => t.isArchived.equals(false)))
        .watch()
        .map((rows) => rows.map(_toDebtModel).toList());
  }

  /// The single currently-open (unpaid) occurrence for a recurring debt, if
  /// any has been generated yet.
  Stream<DebtOccurrence?> watchOpenOccurrence(String recurringDebtId) {
    final query = _db.select(_db.debtOccurrences)
      ..where((t) =>
          t.recurringDebtId.equals(recurringDebtId) & t.isPaid.equals(false))
      ..orderBy([(t) => OrderingTerm.desc(t.cycleIndex)])
      ..limit(1);
    return query.watchSingleOrNull().map(
          (row) => row == null ? null : _toOccurrenceModel(row),
        );
  }

  Stream<DebtOccurrenceWithParent?> watchOccurrenceById(String occurrenceId) {
    final query = _db.select(_db.debtOccurrences).join([
      innerJoin(_db.recurringDebts,
          _db.recurringDebts.id.equalsExp(_db.debtOccurrences.recurringDebtId)),
    ])
      ..where(_db.debtOccurrences.id.equals(occurrenceId));

    return query.watchSingleOrNull().map((row) => row == null
        ? null
        : DebtOccurrenceWithParent(
            occurrence: _toOccurrenceModel(row.readTable(_db.debtOccurrences)),
            parent: _toDebtModel(row.readTable(_db.recurringDebts)),
          ));
  }

  Stream<List<DebtOccurrenceWithParent>> watchAllOpenOccurrences() {
    final query = _db.select(_db.debtOccurrences).join([
      innerJoin(_db.recurringDebts,
          _db.recurringDebts.id.equalsExp(_db.debtOccurrences.recurringDebtId)),
    ])
      ..where(_db.debtOccurrences.isPaid.equals(false) &
          _db.recurringDebts.isArchived.equals(false));

    return query.watch().map((rows) => rows
        .map((row) => DebtOccurrenceWithParent(
              occurrence: _toOccurrenceModel(row.readTable(_db.debtOccurrences)),
              parent: _toDebtModel(row.readTable(_db.recurringDebts)),
            ))
        .toList());
  }

  Stream<List<DebtOccurrenceWithParent>> watchPaidOccurrences() {
    final query = _db.select(_db.debtOccurrences).join([
      innerJoin(_db.recurringDebts,
          _db.recurringDebts.id.equalsExp(_db.debtOccurrences.recurringDebtId)),
    ])
      ..where(_db.debtOccurrences.isPaid.equals(true))
      ..orderBy([OrderingTerm.desc(_db.debtOccurrences.paidAt)]);

    return query.watch().map((rows) => rows
        .map((row) => DebtOccurrenceWithParent(
              occurrence: _toOccurrenceModel(row.readTable(_db.debtOccurrences)),
              parent: _toDebtModel(row.readTable(_db.recurringDebts)),
            ))
        .toList());
  }

  Future<String> create({
    required String title,
    required String payee,
    required double defaultAmount,
    required FrequencyType frequencyType,
    int? intervalDays,
    int? dayOfMonth,
    required DateTime anchorDate,
    String? notes,
    required String currencyCode,
  }) async {
    final debtId = const Uuid().v4();

    await _db.into(_db.recurringDebts).insert(
          RecurringDebtsCompanion.insert(
            id: debtId,
            title: title,
            payee: payee,
            defaultAmount: defaultAmount,
            frequencyType: frequencyType,
            intervalDays: Value(intervalDays),
            dayOfMonth: Value(dayOfMonth),
            anchorDate: anchorDate,
            notes: Value(notes),
          ),
        );

    await _createOccurrence(
      recurringDebtId: debtId,
      expectedDueDate: anchorDate,
      amount: defaultAmount,
      cycleIndex: 0,
      payee: payee,
      currencyCode: currencyCode,
    );

    return debtId;
  }

  Future<void> _createOccurrence({
    required String recurringDebtId,
    required DateTime expectedDueDate,
    required double amount,
    required int cycleIndex,
    required String payee,
    required String currencyCode,
  }) async {
    final occurrenceId = const Uuid().v4();
    await _db.into(_db.debtOccurrences).insert(
          DebtOccurrencesCompanion.insert(
            id: occurrenceId,
            recurringDebtId: recurringDebtId,
            expectedDueDate: expectedDueDate,
            amount: amount,
            cycleIndex: cycleIndex,
          ),
        );

    await _scheduler.scheduleFor(
      kind: DebtKind.recurringOccurrence,
      referenceId: occurrenceId,
      dueDate: expectedDueDate,
      amount: amount,
      payee: payee,
      currencyCode: currencyCode,
    );
  }

  /// Marks the given occurrence paid and generates the next cycle's
  /// occurrence, always computed from the *expected* due date of the
  /// occurrence being paid — never from when it was actually paid.
  Future<void> markOccurrencePaid(String occurrenceId, {required String currencyCode}) async {
    await _db.transaction(() async {
      final occurrenceRow = await (_db.select(_db.debtOccurrences)
            ..where((t) => t.id.equals(occurrenceId)))
          .getSingle();

      final parentRow = await (_db.select(_db.recurringDebts)
            ..where((t) => t.id.equals(occurrenceRow.recurringDebtId)))
          .getSingle();

      await (_db.update(_db.debtOccurrences)
            ..where((t) => t.id.equals(occurrenceId)))
          .write(DebtOccurrencesCompanion(
        isPaid: const Value(true),
        paidAt: Value(clock.now()),
      ));

      await _scheduler.cancelAllFor(occurrenceId);

      final nextDueDate = computeNextExpectedDate(
        previousExpectedDate: occurrenceRow.expectedDueDate,
        type: parentRow.frequencyType,
        intervalDays: parentRow.intervalDays,
        dayOfMonth: parentRow.dayOfMonth,
      );

      await _createOccurrence(
        recurringDebtId: parentRow.id,
        expectedDueDate: nextDueDate,
        amount: parentRow.defaultAmount,
        cycleIndex: occurrenceRow.cycleIndex + 1,
        payee: parentRow.payee,
        currencyCode: currencyCode,
      );
    });
  }

  /// Updates the amount on the current open occurrence only (e.g. this
  /// month's electricity bill differs from the default), without shifting
  /// its due date or the future recurrence schedule.
  Future<void> updateOccurrenceAmount({
    required String occurrenceId,
    required double amount,
    required String payee,
    required DateTime dueDate,
    required String currencyCode,
  }) async {
    await (_db.update(_db.debtOccurrences)
          ..where((t) => t.id.equals(occurrenceId)))
        .write(DebtOccurrencesCompanion(amount: Value(amount)));

    await _scheduler.cancelAllFor(occurrenceId);
    await _scheduler.scheduleFor(
      kind: DebtKind.recurringOccurrence,
      referenceId: occurrenceId,
      dueDate: dueDate,
      amount: amount,
      payee: payee,
      currencyCode: currencyCode,
    );
  }

  Future<void> archive(String recurringDebtId) async {
    final openOccurrences = await (_db.select(_db.debtOccurrences)
          ..where((t) =>
              t.recurringDebtId.equals(recurringDebtId) &
              t.isPaid.equals(false)))
        .get();

    for (final occurrence in openOccurrences) {
      await _scheduler.cancelAllFor(occurrence.id);
    }

    await (_db.update(_db.recurringDebts)
          ..where((t) => t.id.equals(recurringDebtId)))
        .write(const RecurringDebtsCompanion(isArchived: Value(true)));
  }

  RecurringDebt _toDebtModel(RecurringDebtRow row) {
    return RecurringDebt(
      id: row.id,
      title: row.title,
      payee: row.payee,
      defaultAmount: row.defaultAmount,
      frequencyType: row.frequencyType,
      intervalDays: row.intervalDays,
      dayOfMonth: row.dayOfMonth,
      anchorDate: row.anchorDate,
      notes: row.notes,
      isArchived: row.isArchived,
      createdAt: row.createdAt,
    );
  }

  DebtOccurrence _toOccurrenceModel(DebtOccurrenceRow row) {
    return DebtOccurrence(
      id: row.id,
      recurringDebtId: row.recurringDebtId,
      expectedDueDate: row.expectedDueDate,
      amount: row.amount,
      isPaid: row.isPaid,
      paidAt: row.paidAt,
      cycleIndex: row.cycleIndex,
    );
  }
}

class DebtOccurrenceWithParent {
  final DebtOccurrence occurrence;
  final RecurringDebt parent;

  const DebtOccurrenceWithParent({required this.occurrence, required this.parent});
}
