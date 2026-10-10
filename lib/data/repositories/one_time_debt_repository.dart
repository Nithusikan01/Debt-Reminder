import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/enums/debt_kind.dart';
import '../../domain/models/one_time_debt.dart';
import '../../domain/reminder_scheduler.dart';
import '../local/database.dart';

class OneTimeDebtRepository {
  final AppDatabase _db;
  final ReminderScheduler _scheduler;

  OneTimeDebtRepository(this._db, this._scheduler);

  Stream<List<OneTimeDebt>> watchAll() {
    return _db.select(_db.oneTimeDebts).watch().map(
          (rows) => rows.map(_toModel).toList(),
        );
  }

  Future<OneTimeDebt?> getById(String id) async {
    final row = await (_db.select(_db.oneTimeDebts)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Stream<OneTimeDebt?> watchById(String id) {
    return (_db.select(_db.oneTimeDebts)..where((t) => t.id.equals(id)))
        .watchSingleOrNull()
        .map((row) => row == null ? null : _toModel(row));
  }

  Future<String> create({
    required String payee,
    required double amount,
    required DateTime dueDate,
    String? chequeNumber,
    String? paymentMethod,
    String? notes,
    required String currencyCode,
  }) async {
    final id = const Uuid().v4();
    await _db.into(_db.oneTimeDebts).insert(
          OneTimeDebtsCompanion.insert(
            id: id,
            payee: payee,
            amount: amount,
            dueDate: dueDate,
            chequeNumber: Value(chequeNumber),
            paymentMethod: Value(paymentMethod),
            notes: Value(notes),
          ),
        );

    await _scheduler.scheduleFor(
      kind: DebtKind.oneTime,
      referenceId: id,
      dueDate: dueDate,
      amount: amount,
      payee: payee,
      chequeNumber: chequeNumber,
      currencyCode: currencyCode,
    );

    return id;
  }

  Future<void> update({
    required String id,
    required String payee,
    required double amount,
    required DateTime dueDate,
    String? chequeNumber,
    String? paymentMethod,
    String? notes,
    required String currencyCode,
  }) async {
    await (_db.update(_db.oneTimeDebts)..where((t) => t.id.equals(id))).write(
      OneTimeDebtsCompanion(
        payee: Value(payee),
        amount: Value(amount),
        dueDate: Value(dueDate),
        chequeNumber: Value(chequeNumber),
        paymentMethod: Value(paymentMethod),
        notes: Value(notes),
      ),
    );

    await _scheduler.cancelAllFor(id);
    await _scheduler.scheduleFor(
      kind: DebtKind.oneTime,
      referenceId: id,
      dueDate: dueDate,
      amount: amount,
      payee: payee,
      chequeNumber: chequeNumber,
      currencyCode: currencyCode,
    );
  }

  Future<void> markPaid(String id) async {
    await (_db.update(_db.oneTimeDebts)..where((t) => t.id.equals(id))).write(
      OneTimeDebtsCompanion(
        isPaid: const Value(true),
        paidAt: Value(DateTime.now()),
      ),
    );
    await _scheduler.cancelAllFor(id);
  }

  Future<void> delete(String id) async {
    await _scheduler.cancelAllFor(id);
    await (_db.delete(_db.oneTimeDebts)..where((t) => t.id.equals(id))).go();
  }

  OneTimeDebt _toModel(OneTimeDebtRow row) {
    return OneTimeDebt(
      id: row.id,
      payee: row.payee,
      amount: row.amount,
      dueDate: row.dueDate,
      chequeNumber: row.chequeNumber,
      paymentMethod: row.paymentMethod,
      notes: row.notes,
      isPaid: row.isPaid,
      paidAt: row.paidAt,
      createdAt: row.createdAt,
    );
  }
}
