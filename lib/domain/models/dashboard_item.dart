import '../../core/enums/debt_kind.dart';

/// Unified view model the dashboard and history screens render, hiding the
/// distinction between a one-time debt row and a recurring debt's current
/// occurrence row.
class DashboardItem {
  final String referenceId;
  final DebtKind kind;
  final String title;
  final String payee;
  final double amount;
  final DateTime dueDate;
  final String? chequeNumber;
  final bool isPaid;

  const DashboardItem({
    required this.referenceId,
    required this.kind,
    required this.title,
    required this.payee,
    required this.amount,
    required this.dueDate,
    this.chequeNumber,
    required this.isPaid,
  });

  bool get isOverdue => !isPaid && dueDate.isBefore(_today);

  /// Whole calendar days from today until [dueDate]. Negative when overdue.
  int get daysUntilDue {
    final due = DateTime(dueDate.year, dueDate.month, dueDate.day);
    return due.difference(_today).inDays;
  }

  static DateTime get _today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}
