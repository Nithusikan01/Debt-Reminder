import 'package:rxdart/rxdart.dart';

import '../../core/enums/debt_kind.dart';
import '../../domain/models/dashboard_item.dart';
import 'one_time_debt_repository.dart';
import 'recurring_debt_repository.dart';

/// Combines one-time debts and recurring debts' open occurrences into the
/// single [DashboardItem] shape the dashboard and history screens render,
/// sorted by due date.
class DashboardRepository {
  final OneTimeDebtRepository _oneTimeRepo;
  final RecurringDebtRepository _recurringRepo;

  DashboardRepository(this._oneTimeRepo, this._recurringRepo);

  Stream<List<DashboardItem>> watchUpcoming() {
    return Rx.combineLatest2(
      _oneTimeRepo.watchAll(),
      _recurringRepo.watchAllOpenOccurrences(),
      (oneTimeDebts, openOccurrences) {
        final items = <DashboardItem>[
          ...oneTimeDebts.where((d) => !d.isPaid).map((d) => DashboardItem(
                referenceId: d.id,
                kind: DebtKind.oneTime,
                title: 'Payment',
                payee: d.payee,
                amount: d.amount,
                dueDate: d.dueDate,
                chequeNumber: d.chequeNumber,
                isPaid: d.isPaid,
              )),
          ...openOccurrences.map((o) => DashboardItem(
                referenceId: o.occurrence.id,
                kind: DebtKind.recurringOccurrence,
                title: o.parent.title,
                payee: o.parent.payee,
                amount: o.occurrence.amount,
                dueDate: o.occurrence.expectedDueDate,
                isPaid: o.occurrence.isPaid,
              )),
        ];
        items.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        return items;
      },
    );
  }

  Stream<List<DashboardItem>> watchHistory() {
    return Rx.combineLatest2(
      _oneTimeRepo.watchAll(),
      _recurringRepo.watchPaidOccurrences(),
      (oneTimeDebts, paidOccurrences) {
        final items = <DashboardItem>[
          ...oneTimeDebts.where((d) => d.isPaid).map((d) => DashboardItem(
                referenceId: d.id,
                kind: DebtKind.oneTime,
                title: 'Payment',
                payee: d.payee,
                amount: d.amount,
                dueDate: d.dueDate,
                chequeNumber: d.chequeNumber,
                isPaid: d.isPaid,
              )),
          ...paidOccurrences.map((o) => DashboardItem(
                referenceId: o.occurrence.id,
                kind: DebtKind.recurringOccurrence,
                title: o.parent.title,
                payee: o.parent.payee,
                amount: o.occurrence.amount,
                dueDate: o.occurrence.expectedDueDate,
                isPaid: o.occurrence.isPaid,
              )),
        ];
        items.sort((a, b) => b.dueDate.compareTo(a.dueDate));
        return items;
      },
    );
  }
}
