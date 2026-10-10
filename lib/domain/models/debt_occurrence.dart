/// One payable cycle generated from a [RecurringDebt].
///
/// [expectedDueDate] is the immutable scheduling anchor: the next
/// occurrence is always computed from this field, never from [paidAt].
/// See `next_due_date_calculator.dart`.
class DebtOccurrence {
  final String id;
  final String recurringDebtId;
  final DateTime expectedDueDate;
  final double amount;
  final bool isPaid;
  final DateTime? paidAt;
  final int cycleIndex;

  const DebtOccurrence({
    required this.id,
    required this.recurringDebtId,
    required this.expectedDueDate,
    required this.amount,
    required this.isPaid,
    this.paidAt,
    required this.cycleIndex,
  });

  DebtOccurrence copyWith({
    double? amount,
    bool? isPaid,
    DateTime? paidAt,
  }) {
    return DebtOccurrence(
      id: id,
      recurringDebtId: recurringDebtId,
      expectedDueDate: expectedDueDate,
      amount: amount ?? this.amount,
      isPaid: isPaid ?? this.isPaid,
      paidAt: paidAt ?? this.paidAt,
      cycleIndex: cycleIndex,
    );
  }
}
