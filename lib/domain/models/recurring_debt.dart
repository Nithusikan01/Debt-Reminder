import '../../core/enums/frequency_type.dart';

class RecurringDebt {
  final String id;
  final String title;
  final String payee;
  final double defaultAmount;
  final FrequencyType frequencyType;
  final int? intervalDays;
  final int? dayOfMonth;
  final DateTime anchorDate;
  final String? notes;
  final bool isArchived;
  final DateTime createdAt;

  const RecurringDebt({
    required this.id,
    required this.title,
    required this.payee,
    required this.defaultAmount,
    required this.frequencyType,
    this.intervalDays,
    this.dayOfMonth,
    required this.anchorDate,
    this.notes,
    required this.isArchived,
    required this.createdAt,
  });

  RecurringDebt copyWith({
    String? title,
    String? payee,
    double? defaultAmount,
    FrequencyType? frequencyType,
    int? intervalDays,
    int? dayOfMonth,
    DateTime? anchorDate,
    String? notes,
    bool? isArchived,
  }) {
    return RecurringDebt(
      id: id,
      title: title ?? this.title,
      payee: payee ?? this.payee,
      defaultAmount: defaultAmount ?? this.defaultAmount,
      frequencyType: frequencyType ?? this.frequencyType,
      intervalDays: intervalDays ?? this.intervalDays,
      dayOfMonth: dayOfMonth ?? this.dayOfMonth,
      anchorDate: anchorDate ?? this.anchorDate,
      notes: notes ?? this.notes,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt,
    );
  }
}
