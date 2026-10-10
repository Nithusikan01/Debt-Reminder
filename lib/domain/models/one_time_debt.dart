class OneTimeDebt {
  final String id;
  final String payee;
  final double amount;
  final DateTime dueDate;
  final String? chequeNumber;
  final String? paymentMethod;
  final String? notes;
  final bool isPaid;
  final DateTime? paidAt;
  final DateTime createdAt;

  const OneTimeDebt({
    required this.id,
    required this.payee,
    required this.amount,
    required this.dueDate,
    this.chequeNumber,
    this.paymentMethod,
    this.notes,
    required this.isPaid,
    this.paidAt,
    required this.createdAt,
  });

  OneTimeDebt copyWith({
    String? payee,
    double? amount,
    DateTime? dueDate,
    String? chequeNumber,
    String? paymentMethod,
    String? notes,
    bool? isPaid,
    DateTime? paidAt,
  }) {
    return OneTimeDebt(
      id: id,
      payee: payee ?? this.payee,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
      chequeNumber: chequeNumber ?? this.chequeNumber,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
      isPaid: isPaid ?? this.isPaid,
      paidAt: paidAt ?? this.paidAt,
      createdAt: createdAt,
    );
  }
}
