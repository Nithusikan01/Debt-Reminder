// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $OneTimeDebtsTable extends OneTimeDebts
    with TableInfo<$OneTimeDebtsTable, OneTimeDebtRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OneTimeDebtsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payeeMeta = const VerificationMeta('payee');
  @override
  late final GeneratedColumn<String> payee = GeneratedColumn<String>(
      'payee', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _chequeNumberMeta =
      const VerificationMeta('chequeNumber');
  @override
  late final GeneratedColumn<String> chequeNumber = GeneratedColumn<String>(
      'cheque_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _paymentMethodMeta =
      const VerificationMeta('paymentMethod');
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
      'payment_method', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isPaidMeta = const VerificationMeta('isPaid');
  @override
  late final GeneratedColumn<bool> isPaid = GeneratedColumn<bool>(
      'is_paid', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_paid" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
      'paid_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        payee,
        amount,
        dueDate,
        chequeNumber,
        paymentMethod,
        notes,
        isPaid,
        paidAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'one_time_debts';
  @override
  VerificationContext validateIntegrity(Insertable<OneTimeDebtRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('payee')) {
      context.handle(
          _payeeMeta, payee.isAcceptableOrUnknown(data['payee']!, _payeeMeta));
    } else if (isInserting) {
      context.missing(_payeeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('cheque_number')) {
      context.handle(
          _chequeNumberMeta,
          chequeNumber.isAcceptableOrUnknown(
              data['cheque_number']!, _chequeNumberMeta));
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('is_paid')) {
      context.handle(_isPaidMeta,
          isPaid.isAcceptableOrUnknown(data['is_paid']!, _isPaidMeta));
    }
    if (data.containsKey('paid_at')) {
      context.handle(_paidAtMeta,
          paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OneTimeDebtRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OneTimeDebtRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      payee: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payee'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date'])!,
      chequeNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cheque_number']),
      paymentMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_method']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      isPaid: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_paid'])!,
      paidAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}paid_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $OneTimeDebtsTable createAlias(String alias) {
    return $OneTimeDebtsTable(attachedDatabase, alias);
  }
}

class OneTimeDebtRow extends DataClass implements Insertable<OneTimeDebtRow> {
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
  const OneTimeDebtRow(
      {required this.id,
      required this.payee,
      required this.amount,
      required this.dueDate,
      this.chequeNumber,
      this.paymentMethod,
      this.notes,
      required this.isPaid,
      this.paidAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['payee'] = Variable<String>(payee);
    map['amount'] = Variable<double>(amount);
    map['due_date'] = Variable<DateTime>(dueDate);
    if (!nullToAbsent || chequeNumber != null) {
      map['cheque_number'] = Variable<String>(chequeNumber);
    }
    if (!nullToAbsent || paymentMethod != null) {
      map['payment_method'] = Variable<String>(paymentMethod);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_paid'] = Variable<bool>(isPaid);
    if (!nullToAbsent || paidAt != null) {
      map['paid_at'] = Variable<DateTime>(paidAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  OneTimeDebtsCompanion toCompanion(bool nullToAbsent) {
    return OneTimeDebtsCompanion(
      id: Value(id),
      payee: Value(payee),
      amount: Value(amount),
      dueDate: Value(dueDate),
      chequeNumber: chequeNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(chequeNumber),
      paymentMethod: paymentMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMethod),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      isPaid: Value(isPaid),
      paidAt:
          paidAt == null && nullToAbsent ? const Value.absent() : Value(paidAt),
      createdAt: Value(createdAt),
    );
  }

  factory OneTimeDebtRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OneTimeDebtRow(
      id: serializer.fromJson<String>(json['id']),
      payee: serializer.fromJson<String>(json['payee']),
      amount: serializer.fromJson<double>(json['amount']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      chequeNumber: serializer.fromJson<String?>(json['chequeNumber']),
      paymentMethod: serializer.fromJson<String?>(json['paymentMethod']),
      notes: serializer.fromJson<String?>(json['notes']),
      isPaid: serializer.fromJson<bool>(json['isPaid']),
      paidAt: serializer.fromJson<DateTime?>(json['paidAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'payee': serializer.toJson<String>(payee),
      'amount': serializer.toJson<double>(amount),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'chequeNumber': serializer.toJson<String?>(chequeNumber),
      'paymentMethod': serializer.toJson<String?>(paymentMethod),
      'notes': serializer.toJson<String?>(notes),
      'isPaid': serializer.toJson<bool>(isPaid),
      'paidAt': serializer.toJson<DateTime?>(paidAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  OneTimeDebtRow copyWith(
          {String? id,
          String? payee,
          double? amount,
          DateTime? dueDate,
          Value<String?> chequeNumber = const Value.absent(),
          Value<String?> paymentMethod = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          bool? isPaid,
          Value<DateTime?> paidAt = const Value.absent(),
          DateTime? createdAt}) =>
      OneTimeDebtRow(
        id: id ?? this.id,
        payee: payee ?? this.payee,
        amount: amount ?? this.amount,
        dueDate: dueDate ?? this.dueDate,
        chequeNumber:
            chequeNumber.present ? chequeNumber.value : this.chequeNumber,
        paymentMethod:
            paymentMethod.present ? paymentMethod.value : this.paymentMethod,
        notes: notes.present ? notes.value : this.notes,
        isPaid: isPaid ?? this.isPaid,
        paidAt: paidAt.present ? paidAt.value : this.paidAt,
        createdAt: createdAt ?? this.createdAt,
      );
  OneTimeDebtRow copyWithCompanion(OneTimeDebtsCompanion data) {
    return OneTimeDebtRow(
      id: data.id.present ? data.id.value : this.id,
      payee: data.payee.present ? data.payee.value : this.payee,
      amount: data.amount.present ? data.amount.value : this.amount,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      chequeNumber: data.chequeNumber.present
          ? data.chequeNumber.value
          : this.chequeNumber,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      notes: data.notes.present ? data.notes.value : this.notes,
      isPaid: data.isPaid.present ? data.isPaid.value : this.isPaid,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OneTimeDebtRow(')
          ..write('id: $id, ')
          ..write('payee: $payee, ')
          ..write('amount: $amount, ')
          ..write('dueDate: $dueDate, ')
          ..write('chequeNumber: $chequeNumber, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('notes: $notes, ')
          ..write('isPaid: $isPaid, ')
          ..write('paidAt: $paidAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, payee, amount, dueDate, chequeNumber,
      paymentMethod, notes, isPaid, paidAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OneTimeDebtRow &&
          other.id == this.id &&
          other.payee == this.payee &&
          other.amount == this.amount &&
          other.dueDate == this.dueDate &&
          other.chequeNumber == this.chequeNumber &&
          other.paymentMethod == this.paymentMethod &&
          other.notes == this.notes &&
          other.isPaid == this.isPaid &&
          other.paidAt == this.paidAt &&
          other.createdAt == this.createdAt);
}

class OneTimeDebtsCompanion extends UpdateCompanion<OneTimeDebtRow> {
  final Value<String> id;
  final Value<String> payee;
  final Value<double> amount;
  final Value<DateTime> dueDate;
  final Value<String?> chequeNumber;
  final Value<String?> paymentMethod;
  final Value<String?> notes;
  final Value<bool> isPaid;
  final Value<DateTime?> paidAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const OneTimeDebtsCompanion({
    this.id = const Value.absent(),
    this.payee = const Value.absent(),
    this.amount = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.chequeNumber = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.notes = const Value.absent(),
    this.isPaid = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OneTimeDebtsCompanion.insert({
    required String id,
    required String payee,
    required double amount,
    required DateTime dueDate,
    this.chequeNumber = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.notes = const Value.absent(),
    this.isPaid = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        payee = Value(payee),
        amount = Value(amount),
        dueDate = Value(dueDate);
  static Insertable<OneTimeDebtRow> custom({
    Expression<String>? id,
    Expression<String>? payee,
    Expression<double>? amount,
    Expression<DateTime>? dueDate,
    Expression<String>? chequeNumber,
    Expression<String>? paymentMethod,
    Expression<String>? notes,
    Expression<bool>? isPaid,
    Expression<DateTime>? paidAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (payee != null) 'payee': payee,
      if (amount != null) 'amount': amount,
      if (dueDate != null) 'due_date': dueDate,
      if (chequeNumber != null) 'cheque_number': chequeNumber,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (notes != null) 'notes': notes,
      if (isPaid != null) 'is_paid': isPaid,
      if (paidAt != null) 'paid_at': paidAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OneTimeDebtsCompanion copyWith(
      {Value<String>? id,
      Value<String>? payee,
      Value<double>? amount,
      Value<DateTime>? dueDate,
      Value<String?>? chequeNumber,
      Value<String?>? paymentMethod,
      Value<String?>? notes,
      Value<bool>? isPaid,
      Value<DateTime?>? paidAt,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return OneTimeDebtsCompanion(
      id: id ?? this.id,
      payee: payee ?? this.payee,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
      chequeNumber: chequeNumber ?? this.chequeNumber,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
      isPaid: isPaid ?? this.isPaid,
      paidAt: paidAt ?? this.paidAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (payee.present) {
      map['payee'] = Variable<String>(payee.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (chequeNumber.present) {
      map['cheque_number'] = Variable<String>(chequeNumber.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isPaid.present) {
      map['is_paid'] = Variable<bool>(isPaid.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OneTimeDebtsCompanion(')
          ..write('id: $id, ')
          ..write('payee: $payee, ')
          ..write('amount: $amount, ')
          ..write('dueDate: $dueDate, ')
          ..write('chequeNumber: $chequeNumber, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('notes: $notes, ')
          ..write('isPaid: $isPaid, ')
          ..write('paidAt: $paidAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecurringDebtsTable extends RecurringDebts
    with TableInfo<$RecurringDebtsTable, RecurringDebtRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurringDebtsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payeeMeta = const VerificationMeta('payee');
  @override
  late final GeneratedColumn<String> payee = GeneratedColumn<String>(
      'payee', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _defaultAmountMeta =
      const VerificationMeta('defaultAmount');
  @override
  late final GeneratedColumn<double> defaultAmount = GeneratedColumn<double>(
      'default_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<FrequencyType, String>
      frequencyType = GeneratedColumn<String>(
              'frequency_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<FrequencyType>(
              $RecurringDebtsTable.$converterfrequencyType);
  static const VerificationMeta _intervalDaysMeta =
      const VerificationMeta('intervalDays');
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
      'interval_days', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _dayOfMonthMeta =
      const VerificationMeta('dayOfMonth');
  @override
  late final GeneratedColumn<int> dayOfMonth = GeneratedColumn<int>(
      'day_of_month', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _anchorDateMeta =
      const VerificationMeta('anchorDate');
  @override
  late final GeneratedColumn<DateTime> anchorDate = GeneratedColumn<DateTime>(
      'anchor_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isArchivedMeta =
      const VerificationMeta('isArchived');
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
      'is_archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        payee,
        defaultAmount,
        frequencyType,
        intervalDays,
        dayOfMonth,
        anchorDate,
        notes,
        isArchived,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurring_debts';
  @override
  VerificationContext validateIntegrity(Insertable<RecurringDebtRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('payee')) {
      context.handle(
          _payeeMeta, payee.isAcceptableOrUnknown(data['payee']!, _payeeMeta));
    } else if (isInserting) {
      context.missing(_payeeMeta);
    }
    if (data.containsKey('default_amount')) {
      context.handle(
          _defaultAmountMeta,
          defaultAmount.isAcceptableOrUnknown(
              data['default_amount']!, _defaultAmountMeta));
    } else if (isInserting) {
      context.missing(_defaultAmountMeta);
    }
    if (data.containsKey('interval_days')) {
      context.handle(
          _intervalDaysMeta,
          intervalDays.isAcceptableOrUnknown(
              data['interval_days']!, _intervalDaysMeta));
    }
    if (data.containsKey('day_of_month')) {
      context.handle(
          _dayOfMonthMeta,
          dayOfMonth.isAcceptableOrUnknown(
              data['day_of_month']!, _dayOfMonthMeta));
    }
    if (data.containsKey('anchor_date')) {
      context.handle(
          _anchorDateMeta,
          anchorDate.isAcceptableOrUnknown(
              data['anchor_date']!, _anchorDateMeta));
    } else if (isInserting) {
      context.missing(_anchorDateMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('is_archived')) {
      context.handle(
          _isArchivedMeta,
          isArchived.isAcceptableOrUnknown(
              data['is_archived']!, _isArchivedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurringDebtRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurringDebtRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      payee: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payee'])!,
      defaultAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}default_amount'])!,
      frequencyType: $RecurringDebtsTable.$converterfrequencyType.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}frequency_type'])!),
      intervalDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}interval_days']),
      dayOfMonth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}day_of_month']),
      anchorDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}anchor_date'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      isArchived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_archived'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $RecurringDebtsTable createAlias(String alias) {
    return $RecurringDebtsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FrequencyType, String, String>
      $converterfrequencyType =
      const EnumNameConverter<FrequencyType>(FrequencyType.values);
}

class RecurringDebtRow extends DataClass
    implements Insertable<RecurringDebtRow> {
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
  const RecurringDebtRow(
      {required this.id,
      required this.title,
      required this.payee,
      required this.defaultAmount,
      required this.frequencyType,
      this.intervalDays,
      this.dayOfMonth,
      required this.anchorDate,
      this.notes,
      required this.isArchived,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['payee'] = Variable<String>(payee);
    map['default_amount'] = Variable<double>(defaultAmount);
    {
      map['frequency_type'] = Variable<String>(
          $RecurringDebtsTable.$converterfrequencyType.toSql(frequencyType));
    }
    if (!nullToAbsent || intervalDays != null) {
      map['interval_days'] = Variable<int>(intervalDays);
    }
    if (!nullToAbsent || dayOfMonth != null) {
      map['day_of_month'] = Variable<int>(dayOfMonth);
    }
    map['anchor_date'] = Variable<DateTime>(anchorDate);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RecurringDebtsCompanion toCompanion(bool nullToAbsent) {
    return RecurringDebtsCompanion(
      id: Value(id),
      title: Value(title),
      payee: Value(payee),
      defaultAmount: Value(defaultAmount),
      frequencyType: Value(frequencyType),
      intervalDays: intervalDays == null && nullToAbsent
          ? const Value.absent()
          : Value(intervalDays),
      dayOfMonth: dayOfMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(dayOfMonth),
      anchorDate: Value(anchorDate),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
    );
  }

  factory RecurringDebtRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurringDebtRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      payee: serializer.fromJson<String>(json['payee']),
      defaultAmount: serializer.fromJson<double>(json['defaultAmount']),
      frequencyType: $RecurringDebtsTable.$converterfrequencyType
          .fromJson(serializer.fromJson<String>(json['frequencyType'])),
      intervalDays: serializer.fromJson<int?>(json['intervalDays']),
      dayOfMonth: serializer.fromJson<int?>(json['dayOfMonth']),
      anchorDate: serializer.fromJson<DateTime>(json['anchorDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'payee': serializer.toJson<String>(payee),
      'defaultAmount': serializer.toJson<double>(defaultAmount),
      'frequencyType': serializer.toJson<String>(
          $RecurringDebtsTable.$converterfrequencyType.toJson(frequencyType)),
      'intervalDays': serializer.toJson<int?>(intervalDays),
      'dayOfMonth': serializer.toJson<int?>(dayOfMonth),
      'anchorDate': serializer.toJson<DateTime>(anchorDate),
      'notes': serializer.toJson<String?>(notes),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RecurringDebtRow copyWith(
          {String? id,
          String? title,
          String? payee,
          double? defaultAmount,
          FrequencyType? frequencyType,
          Value<int?> intervalDays = const Value.absent(),
          Value<int?> dayOfMonth = const Value.absent(),
          DateTime? anchorDate,
          Value<String?> notes = const Value.absent(),
          bool? isArchived,
          DateTime? createdAt}) =>
      RecurringDebtRow(
        id: id ?? this.id,
        title: title ?? this.title,
        payee: payee ?? this.payee,
        defaultAmount: defaultAmount ?? this.defaultAmount,
        frequencyType: frequencyType ?? this.frequencyType,
        intervalDays:
            intervalDays.present ? intervalDays.value : this.intervalDays,
        dayOfMonth: dayOfMonth.present ? dayOfMonth.value : this.dayOfMonth,
        anchorDate: anchorDate ?? this.anchorDate,
        notes: notes.present ? notes.value : this.notes,
        isArchived: isArchived ?? this.isArchived,
        createdAt: createdAt ?? this.createdAt,
      );
  RecurringDebtRow copyWithCompanion(RecurringDebtsCompanion data) {
    return RecurringDebtRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      payee: data.payee.present ? data.payee.value : this.payee,
      defaultAmount: data.defaultAmount.present
          ? data.defaultAmount.value
          : this.defaultAmount,
      frequencyType: data.frequencyType.present
          ? data.frequencyType.value
          : this.frequencyType,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      dayOfMonth:
          data.dayOfMonth.present ? data.dayOfMonth.value : this.dayOfMonth,
      anchorDate:
          data.anchorDate.present ? data.anchorDate.value : this.anchorDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      isArchived:
          data.isArchived.present ? data.isArchived.value : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurringDebtRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('payee: $payee, ')
          ..write('defaultAmount: $defaultAmount, ')
          ..write('frequencyType: $frequencyType, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('dayOfMonth: $dayOfMonth, ')
          ..write('anchorDate: $anchorDate, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      payee,
      defaultAmount,
      frequencyType,
      intervalDays,
      dayOfMonth,
      anchorDate,
      notes,
      isArchived,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurringDebtRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.payee == this.payee &&
          other.defaultAmount == this.defaultAmount &&
          other.frequencyType == this.frequencyType &&
          other.intervalDays == this.intervalDays &&
          other.dayOfMonth == this.dayOfMonth &&
          other.anchorDate == this.anchorDate &&
          other.notes == this.notes &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt);
}

class RecurringDebtsCompanion extends UpdateCompanion<RecurringDebtRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> payee;
  final Value<double> defaultAmount;
  final Value<FrequencyType> frequencyType;
  final Value<int?> intervalDays;
  final Value<int?> dayOfMonth;
  final Value<DateTime> anchorDate;
  final Value<String?> notes;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RecurringDebtsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.payee = const Value.absent(),
    this.defaultAmount = const Value.absent(),
    this.frequencyType = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.dayOfMonth = const Value.absent(),
    this.anchorDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecurringDebtsCompanion.insert({
    required String id,
    required String title,
    required String payee,
    required double defaultAmount,
    required FrequencyType frequencyType,
    this.intervalDays = const Value.absent(),
    this.dayOfMonth = const Value.absent(),
    required DateTime anchorDate,
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        payee = Value(payee),
        defaultAmount = Value(defaultAmount),
        frequencyType = Value(frequencyType),
        anchorDate = Value(anchorDate);
  static Insertable<RecurringDebtRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? payee,
    Expression<double>? defaultAmount,
    Expression<String>? frequencyType,
    Expression<int>? intervalDays,
    Expression<int>? dayOfMonth,
    Expression<DateTime>? anchorDate,
    Expression<String>? notes,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (payee != null) 'payee': payee,
      if (defaultAmount != null) 'default_amount': defaultAmount,
      if (frequencyType != null) 'frequency_type': frequencyType,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (dayOfMonth != null) 'day_of_month': dayOfMonth,
      if (anchorDate != null) 'anchor_date': anchorDate,
      if (notes != null) 'notes': notes,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecurringDebtsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? payee,
      Value<double>? defaultAmount,
      Value<FrequencyType>? frequencyType,
      Value<int?>? intervalDays,
      Value<int?>? dayOfMonth,
      Value<DateTime>? anchorDate,
      Value<String?>? notes,
      Value<bool>? isArchived,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return RecurringDebtsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      payee: payee ?? this.payee,
      defaultAmount: defaultAmount ?? this.defaultAmount,
      frequencyType: frequencyType ?? this.frequencyType,
      intervalDays: intervalDays ?? this.intervalDays,
      dayOfMonth: dayOfMonth ?? this.dayOfMonth,
      anchorDate: anchorDate ?? this.anchorDate,
      notes: notes ?? this.notes,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (payee.present) {
      map['payee'] = Variable<String>(payee.value);
    }
    if (defaultAmount.present) {
      map['default_amount'] = Variable<double>(defaultAmount.value);
    }
    if (frequencyType.present) {
      map['frequency_type'] = Variable<String>($RecurringDebtsTable
          .$converterfrequencyType
          .toSql(frequencyType.value));
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (dayOfMonth.present) {
      map['day_of_month'] = Variable<int>(dayOfMonth.value);
    }
    if (anchorDate.present) {
      map['anchor_date'] = Variable<DateTime>(anchorDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurringDebtsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('payee: $payee, ')
          ..write('defaultAmount: $defaultAmount, ')
          ..write('frequencyType: $frequencyType, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('dayOfMonth: $dayOfMonth, ')
          ..write('anchorDate: $anchorDate, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DebtOccurrencesTable extends DebtOccurrences
    with TableInfo<$DebtOccurrencesTable, DebtOccurrenceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebtOccurrencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recurringDebtIdMeta =
      const VerificationMeta('recurringDebtId');
  @override
  late final GeneratedColumn<String> recurringDebtId = GeneratedColumn<String>(
      'recurring_debt_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES recurring_debts (id)'));
  static const VerificationMeta _expectedDueDateMeta =
      const VerificationMeta('expectedDueDate');
  @override
  late final GeneratedColumn<DateTime> expectedDueDate =
      GeneratedColumn<DateTime>('expected_due_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _isPaidMeta = const VerificationMeta('isPaid');
  @override
  late final GeneratedColumn<bool> isPaid = GeneratedColumn<bool>(
      'is_paid', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_paid" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
      'paid_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _cycleIndexMeta =
      const VerificationMeta('cycleIndex');
  @override
  late final GeneratedColumn<int> cycleIndex = GeneratedColumn<int>(
      'cycle_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        recurringDebtId,
        expectedDueDate,
        amount,
        isPaid,
        paidAt,
        cycleIndex
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'debt_occurrences';
  @override
  VerificationContext validateIntegrity(Insertable<DebtOccurrenceRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('recurring_debt_id')) {
      context.handle(
          _recurringDebtIdMeta,
          recurringDebtId.isAcceptableOrUnknown(
              data['recurring_debt_id']!, _recurringDebtIdMeta));
    } else if (isInserting) {
      context.missing(_recurringDebtIdMeta);
    }
    if (data.containsKey('expected_due_date')) {
      context.handle(
          _expectedDueDateMeta,
          expectedDueDate.isAcceptableOrUnknown(
              data['expected_due_date']!, _expectedDueDateMeta));
    } else if (isInserting) {
      context.missing(_expectedDueDateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('is_paid')) {
      context.handle(_isPaidMeta,
          isPaid.isAcceptableOrUnknown(data['is_paid']!, _isPaidMeta));
    }
    if (data.containsKey('paid_at')) {
      context.handle(_paidAtMeta,
          paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta));
    }
    if (data.containsKey('cycle_index')) {
      context.handle(
          _cycleIndexMeta,
          cycleIndex.isAcceptableOrUnknown(
              data['cycle_index']!, _cycleIndexMeta));
    } else if (isInserting) {
      context.missing(_cycleIndexMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DebtOccurrenceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DebtOccurrenceRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      recurringDebtId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}recurring_debt_id'])!,
      expectedDueDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}expected_due_date'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      isPaid: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_paid'])!,
      paidAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}paid_at']),
      cycleIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cycle_index'])!,
    );
  }

  @override
  $DebtOccurrencesTable createAlias(String alias) {
    return $DebtOccurrencesTable(attachedDatabase, alias);
  }
}

class DebtOccurrenceRow extends DataClass
    implements Insertable<DebtOccurrenceRow> {
  final String id;
  final String recurringDebtId;
  final DateTime expectedDueDate;
  final double amount;
  final bool isPaid;
  final DateTime? paidAt;
  final int cycleIndex;
  const DebtOccurrenceRow(
      {required this.id,
      required this.recurringDebtId,
      required this.expectedDueDate,
      required this.amount,
      required this.isPaid,
      this.paidAt,
      required this.cycleIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['recurring_debt_id'] = Variable<String>(recurringDebtId);
    map['expected_due_date'] = Variable<DateTime>(expectedDueDate);
    map['amount'] = Variable<double>(amount);
    map['is_paid'] = Variable<bool>(isPaid);
    if (!nullToAbsent || paidAt != null) {
      map['paid_at'] = Variable<DateTime>(paidAt);
    }
    map['cycle_index'] = Variable<int>(cycleIndex);
    return map;
  }

  DebtOccurrencesCompanion toCompanion(bool nullToAbsent) {
    return DebtOccurrencesCompanion(
      id: Value(id),
      recurringDebtId: Value(recurringDebtId),
      expectedDueDate: Value(expectedDueDate),
      amount: Value(amount),
      isPaid: Value(isPaid),
      paidAt:
          paidAt == null && nullToAbsent ? const Value.absent() : Value(paidAt),
      cycleIndex: Value(cycleIndex),
    );
  }

  factory DebtOccurrenceRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DebtOccurrenceRow(
      id: serializer.fromJson<String>(json['id']),
      recurringDebtId: serializer.fromJson<String>(json['recurringDebtId']),
      expectedDueDate: serializer.fromJson<DateTime>(json['expectedDueDate']),
      amount: serializer.fromJson<double>(json['amount']),
      isPaid: serializer.fromJson<bool>(json['isPaid']),
      paidAt: serializer.fromJson<DateTime?>(json['paidAt']),
      cycleIndex: serializer.fromJson<int>(json['cycleIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'recurringDebtId': serializer.toJson<String>(recurringDebtId),
      'expectedDueDate': serializer.toJson<DateTime>(expectedDueDate),
      'amount': serializer.toJson<double>(amount),
      'isPaid': serializer.toJson<bool>(isPaid),
      'paidAt': serializer.toJson<DateTime?>(paidAt),
      'cycleIndex': serializer.toJson<int>(cycleIndex),
    };
  }

  DebtOccurrenceRow copyWith(
          {String? id,
          String? recurringDebtId,
          DateTime? expectedDueDate,
          double? amount,
          bool? isPaid,
          Value<DateTime?> paidAt = const Value.absent(),
          int? cycleIndex}) =>
      DebtOccurrenceRow(
        id: id ?? this.id,
        recurringDebtId: recurringDebtId ?? this.recurringDebtId,
        expectedDueDate: expectedDueDate ?? this.expectedDueDate,
        amount: amount ?? this.amount,
        isPaid: isPaid ?? this.isPaid,
        paidAt: paidAt.present ? paidAt.value : this.paidAt,
        cycleIndex: cycleIndex ?? this.cycleIndex,
      );
  DebtOccurrenceRow copyWithCompanion(DebtOccurrencesCompanion data) {
    return DebtOccurrenceRow(
      id: data.id.present ? data.id.value : this.id,
      recurringDebtId: data.recurringDebtId.present
          ? data.recurringDebtId.value
          : this.recurringDebtId,
      expectedDueDate: data.expectedDueDate.present
          ? data.expectedDueDate.value
          : this.expectedDueDate,
      amount: data.amount.present ? data.amount.value : this.amount,
      isPaid: data.isPaid.present ? data.isPaid.value : this.isPaid,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
      cycleIndex:
          data.cycleIndex.present ? data.cycleIndex.value : this.cycleIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DebtOccurrenceRow(')
          ..write('id: $id, ')
          ..write('recurringDebtId: $recurringDebtId, ')
          ..write('expectedDueDate: $expectedDueDate, ')
          ..write('amount: $amount, ')
          ..write('isPaid: $isPaid, ')
          ..write('paidAt: $paidAt, ')
          ..write('cycleIndex: $cycleIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, recurringDebtId, expectedDueDate, amount, isPaid, paidAt, cycleIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DebtOccurrenceRow &&
          other.id == this.id &&
          other.recurringDebtId == this.recurringDebtId &&
          other.expectedDueDate == this.expectedDueDate &&
          other.amount == this.amount &&
          other.isPaid == this.isPaid &&
          other.paidAt == this.paidAt &&
          other.cycleIndex == this.cycleIndex);
}

class DebtOccurrencesCompanion extends UpdateCompanion<DebtOccurrenceRow> {
  final Value<String> id;
  final Value<String> recurringDebtId;
  final Value<DateTime> expectedDueDate;
  final Value<double> amount;
  final Value<bool> isPaid;
  final Value<DateTime?> paidAt;
  final Value<int> cycleIndex;
  final Value<int> rowid;
  const DebtOccurrencesCompanion({
    this.id = const Value.absent(),
    this.recurringDebtId = const Value.absent(),
    this.expectedDueDate = const Value.absent(),
    this.amount = const Value.absent(),
    this.isPaid = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.cycleIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DebtOccurrencesCompanion.insert({
    required String id,
    required String recurringDebtId,
    required DateTime expectedDueDate,
    required double amount,
    this.isPaid = const Value.absent(),
    this.paidAt = const Value.absent(),
    required int cycleIndex,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        recurringDebtId = Value(recurringDebtId),
        expectedDueDate = Value(expectedDueDate),
        amount = Value(amount),
        cycleIndex = Value(cycleIndex);
  static Insertable<DebtOccurrenceRow> custom({
    Expression<String>? id,
    Expression<String>? recurringDebtId,
    Expression<DateTime>? expectedDueDate,
    Expression<double>? amount,
    Expression<bool>? isPaid,
    Expression<DateTime>? paidAt,
    Expression<int>? cycleIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recurringDebtId != null) 'recurring_debt_id': recurringDebtId,
      if (expectedDueDate != null) 'expected_due_date': expectedDueDate,
      if (amount != null) 'amount': amount,
      if (isPaid != null) 'is_paid': isPaid,
      if (paidAt != null) 'paid_at': paidAt,
      if (cycleIndex != null) 'cycle_index': cycleIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DebtOccurrencesCompanion copyWith(
      {Value<String>? id,
      Value<String>? recurringDebtId,
      Value<DateTime>? expectedDueDate,
      Value<double>? amount,
      Value<bool>? isPaid,
      Value<DateTime?>? paidAt,
      Value<int>? cycleIndex,
      Value<int>? rowid}) {
    return DebtOccurrencesCompanion(
      id: id ?? this.id,
      recurringDebtId: recurringDebtId ?? this.recurringDebtId,
      expectedDueDate: expectedDueDate ?? this.expectedDueDate,
      amount: amount ?? this.amount,
      isPaid: isPaid ?? this.isPaid,
      paidAt: paidAt ?? this.paidAt,
      cycleIndex: cycleIndex ?? this.cycleIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (recurringDebtId.present) {
      map['recurring_debt_id'] = Variable<String>(recurringDebtId.value);
    }
    if (expectedDueDate.present) {
      map['expected_due_date'] = Variable<DateTime>(expectedDueDate.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (isPaid.present) {
      map['is_paid'] = Variable<bool>(isPaid.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    if (cycleIndex.present) {
      map['cycle_index'] = Variable<int>(cycleIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DebtOccurrencesCompanion(')
          ..write('id: $id, ')
          ..write('recurringDebtId: $recurringDebtId, ')
          ..write('expectedDueDate: $expectedDueDate, ')
          ..write('amount: $amount, ')
          ..write('isPaid: $isPaid, ')
          ..write('paidAt: $paidAt, ')
          ..write('cycleIndex: $cycleIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScheduledNotificationsTable extends ScheduledNotifications
    with TableInfo<$ScheduledNotificationsTable, ScheduledNotificationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduledNotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _notificationIdMeta =
      const VerificationMeta('notificationId');
  @override
  late final GeneratedColumn<int> notificationId = GeneratedColumn<int>(
      'notification_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<DebtKind, String> debtType =
      GeneratedColumn<String>('debt_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<DebtKind>(
              $ScheduledNotificationsTable.$converterdebtType);
  static const VerificationMeta _referenceIdMeta =
      const VerificationMeta('referenceId');
  @override
  late final GeneratedColumn<String> referenceId = GeneratedColumn<String>(
      'reference_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<ReminderOffset, String>
      offsetLabel = GeneratedColumn<String>('offset_label', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ReminderOffset>(
              $ScheduledNotificationsTable.$converteroffsetLabel);
  static const VerificationMeta _scheduledForMeta =
      const VerificationMeta('scheduledFor');
  @override
  late final GeneratedColumn<DateTime> scheduledFor = GeneratedColumn<DateTime>(
      'scheduled_for', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [notificationId, debtType, referenceId, offsetLabel, scheduledFor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scheduled_notifications';
  @override
  VerificationContext validateIntegrity(
      Insertable<ScheduledNotificationRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('notification_id')) {
      context.handle(
          _notificationIdMeta,
          notificationId.isAcceptableOrUnknown(
              data['notification_id']!, _notificationIdMeta));
    }
    if (data.containsKey('reference_id')) {
      context.handle(
          _referenceIdMeta,
          referenceId.isAcceptableOrUnknown(
              data['reference_id']!, _referenceIdMeta));
    } else if (isInserting) {
      context.missing(_referenceIdMeta);
    }
    if (data.containsKey('scheduled_for')) {
      context.handle(
          _scheduledForMeta,
          scheduledFor.isAcceptableOrUnknown(
              data['scheduled_for']!, _scheduledForMeta));
    } else if (isInserting) {
      context.missing(_scheduledForMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {notificationId};
  @override
  ScheduledNotificationRow map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduledNotificationRow(
      notificationId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}notification_id'])!,
      debtType: $ScheduledNotificationsTable.$converterdebtType.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}debt_type'])!),
      referenceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference_id'])!,
      offsetLabel: $ScheduledNotificationsTable.$converteroffsetLabel.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}offset_label'])!),
      scheduledFor: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}scheduled_for'])!,
    );
  }

  @override
  $ScheduledNotificationsTable createAlias(String alias) {
    return $ScheduledNotificationsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DebtKind, String, String> $converterdebtType =
      const EnumNameConverter<DebtKind>(DebtKind.values);
  static JsonTypeConverter2<ReminderOffset, String, String>
      $converteroffsetLabel =
      const EnumNameConverter<ReminderOffset>(ReminderOffset.values);
}

class ScheduledNotificationRow extends DataClass
    implements Insertable<ScheduledNotificationRow> {
  final int notificationId;
  final DebtKind debtType;
  final String referenceId;
  final ReminderOffset offsetLabel;
  final DateTime scheduledFor;
  const ScheduledNotificationRow(
      {required this.notificationId,
      required this.debtType,
      required this.referenceId,
      required this.offsetLabel,
      required this.scheduledFor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['notification_id'] = Variable<int>(notificationId);
    {
      map['debt_type'] = Variable<String>(
          $ScheduledNotificationsTable.$converterdebtType.toSql(debtType));
    }
    map['reference_id'] = Variable<String>(referenceId);
    {
      map['offset_label'] = Variable<String>($ScheduledNotificationsTable
          .$converteroffsetLabel
          .toSql(offsetLabel));
    }
    map['scheduled_for'] = Variable<DateTime>(scheduledFor);
    return map;
  }

  ScheduledNotificationsCompanion toCompanion(bool nullToAbsent) {
    return ScheduledNotificationsCompanion(
      notificationId: Value(notificationId),
      debtType: Value(debtType),
      referenceId: Value(referenceId),
      offsetLabel: Value(offsetLabel),
      scheduledFor: Value(scheduledFor),
    );
  }

  factory ScheduledNotificationRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduledNotificationRow(
      notificationId: serializer.fromJson<int>(json['notificationId']),
      debtType: $ScheduledNotificationsTable.$converterdebtType
          .fromJson(serializer.fromJson<String>(json['debtType'])),
      referenceId: serializer.fromJson<String>(json['referenceId']),
      offsetLabel: $ScheduledNotificationsTable.$converteroffsetLabel
          .fromJson(serializer.fromJson<String>(json['offsetLabel'])),
      scheduledFor: serializer.fromJson<DateTime>(json['scheduledFor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'notificationId': serializer.toJson<int>(notificationId),
      'debtType': serializer.toJson<String>(
          $ScheduledNotificationsTable.$converterdebtType.toJson(debtType)),
      'referenceId': serializer.toJson<String>(referenceId),
      'offsetLabel': serializer.toJson<String>($ScheduledNotificationsTable
          .$converteroffsetLabel
          .toJson(offsetLabel)),
      'scheduledFor': serializer.toJson<DateTime>(scheduledFor),
    };
  }

  ScheduledNotificationRow copyWith(
          {int? notificationId,
          DebtKind? debtType,
          String? referenceId,
          ReminderOffset? offsetLabel,
          DateTime? scheduledFor}) =>
      ScheduledNotificationRow(
        notificationId: notificationId ?? this.notificationId,
        debtType: debtType ?? this.debtType,
        referenceId: referenceId ?? this.referenceId,
        offsetLabel: offsetLabel ?? this.offsetLabel,
        scheduledFor: scheduledFor ?? this.scheduledFor,
      );
  ScheduledNotificationRow copyWithCompanion(
      ScheduledNotificationsCompanion data) {
    return ScheduledNotificationRow(
      notificationId: data.notificationId.present
          ? data.notificationId.value
          : this.notificationId,
      debtType: data.debtType.present ? data.debtType.value : this.debtType,
      referenceId:
          data.referenceId.present ? data.referenceId.value : this.referenceId,
      offsetLabel:
          data.offsetLabel.present ? data.offsetLabel.value : this.offsetLabel,
      scheduledFor: data.scheduledFor.present
          ? data.scheduledFor.value
          : this.scheduledFor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduledNotificationRow(')
          ..write('notificationId: $notificationId, ')
          ..write('debtType: $debtType, ')
          ..write('referenceId: $referenceId, ')
          ..write('offsetLabel: $offsetLabel, ')
          ..write('scheduledFor: $scheduledFor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      notificationId, debtType, referenceId, offsetLabel, scheduledFor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduledNotificationRow &&
          other.notificationId == this.notificationId &&
          other.debtType == this.debtType &&
          other.referenceId == this.referenceId &&
          other.offsetLabel == this.offsetLabel &&
          other.scheduledFor == this.scheduledFor);
}

class ScheduledNotificationsCompanion
    extends UpdateCompanion<ScheduledNotificationRow> {
  final Value<int> notificationId;
  final Value<DebtKind> debtType;
  final Value<String> referenceId;
  final Value<ReminderOffset> offsetLabel;
  final Value<DateTime> scheduledFor;
  const ScheduledNotificationsCompanion({
    this.notificationId = const Value.absent(),
    this.debtType = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.offsetLabel = const Value.absent(),
    this.scheduledFor = const Value.absent(),
  });
  ScheduledNotificationsCompanion.insert({
    this.notificationId = const Value.absent(),
    required DebtKind debtType,
    required String referenceId,
    required ReminderOffset offsetLabel,
    required DateTime scheduledFor,
  })  : debtType = Value(debtType),
        referenceId = Value(referenceId),
        offsetLabel = Value(offsetLabel),
        scheduledFor = Value(scheduledFor);
  static Insertable<ScheduledNotificationRow> custom({
    Expression<int>? notificationId,
    Expression<String>? debtType,
    Expression<String>? referenceId,
    Expression<String>? offsetLabel,
    Expression<DateTime>? scheduledFor,
  }) {
    return RawValuesInsertable({
      if (notificationId != null) 'notification_id': notificationId,
      if (debtType != null) 'debt_type': debtType,
      if (referenceId != null) 'reference_id': referenceId,
      if (offsetLabel != null) 'offset_label': offsetLabel,
      if (scheduledFor != null) 'scheduled_for': scheduledFor,
    });
  }

  ScheduledNotificationsCompanion copyWith(
      {Value<int>? notificationId,
      Value<DebtKind>? debtType,
      Value<String>? referenceId,
      Value<ReminderOffset>? offsetLabel,
      Value<DateTime>? scheduledFor}) {
    return ScheduledNotificationsCompanion(
      notificationId: notificationId ?? this.notificationId,
      debtType: debtType ?? this.debtType,
      referenceId: referenceId ?? this.referenceId,
      offsetLabel: offsetLabel ?? this.offsetLabel,
      scheduledFor: scheduledFor ?? this.scheduledFor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (notificationId.present) {
      map['notification_id'] = Variable<int>(notificationId.value);
    }
    if (debtType.present) {
      map['debt_type'] = Variable<String>($ScheduledNotificationsTable
          .$converterdebtType
          .toSql(debtType.value));
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<String>(referenceId.value);
    }
    if (offsetLabel.present) {
      map['offset_label'] = Variable<String>($ScheduledNotificationsTable
          .$converteroffsetLabel
          .toSql(offsetLabel.value));
    }
    if (scheduledFor.present) {
      map['scheduled_for'] = Variable<DateTime>(scheduledFor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduledNotificationsCompanion(')
          ..write('notificationId: $notificationId, ')
          ..write('debtType: $debtType, ')
          ..write('referenceId: $referenceId, ')
          ..write('offsetLabel: $offsetLabel, ')
          ..write('scheduledFor: $scheduledFor')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSettingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _currencyCodeMeta =
      const VerificationMeta('currencyCode');
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
      'currency_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(defaultCurrencyCode));
  @override
  List<GeneratedColumn> get $columns => [id, currencyCode];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(Insertable<AppSettingRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('currency_code')) {
      context.handle(
          _currencyCodeMeta,
          currencyCode.isAcceptableOrUnknown(
              data['currency_code']!, _currencyCodeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSettingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      currencyCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_code'])!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSettingRow extends DataClass implements Insertable<AppSettingRow> {
  final int id;
  final String currencyCode;
  const AppSettingRow({required this.id, required this.currencyCode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['currency_code'] = Variable<String>(currencyCode);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      currencyCode: Value(currencyCode),
    );
  }

  factory AppSettingRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingRow(
      id: serializer.fromJson<int>(json['id']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'currencyCode': serializer.toJson<String>(currencyCode),
    };
  }

  AppSettingRow copyWith({int? id, String? currencyCode}) => AppSettingRow(
        id: id ?? this.id,
        currencyCode: currencyCode ?? this.currencyCode,
      );
  AppSettingRow copyWithCompanion(AppSettingsCompanion data) {
    return AppSettingRow(
      id: data.id.present ? data.id.value : this.id,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingRow(')
          ..write('id: $id, ')
          ..write('currencyCode: $currencyCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, currencyCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingRow &&
          other.id == this.id &&
          other.currencyCode == this.currencyCode);
}

class AppSettingsCompanion extends UpdateCompanion<AppSettingRow> {
  final Value<int> id;
  final Value<String> currencyCode;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.currencyCode = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.currencyCode = const Value.absent(),
  });
  static Insertable<AppSettingRow> custom({
    Expression<int>? id,
    Expression<String>? currencyCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currencyCode != null) 'currency_code': currencyCode,
    });
  }

  AppSettingsCompanion copyWith({Value<int>? id, Value<String>? currencyCode}) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      currencyCode: currencyCode ?? this.currencyCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('currencyCode: $currencyCode')
          ..write(')'))
        .toString();
  }
}

class $PriceCodeLettersTable extends PriceCodeLetters
    with TableInfo<$PriceCodeLettersTable, PriceCodeLetterRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PriceCodeLettersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _letterMeta = const VerificationMeta('letter');
  @override
  late final GeneratedColumn<String> letter = GeneratedColumn<String>(
      'letter', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _digitMeta = const VerificationMeta('digit');
  @override
  late final GeneratedColumn<int> digit = GeneratedColumn<int>(
      'digit', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [letter, digit];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'price_code_letters';
  @override
  VerificationContext validateIntegrity(Insertable<PriceCodeLetterRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('letter')) {
      context.handle(_letterMeta,
          letter.isAcceptableOrUnknown(data['letter']!, _letterMeta));
    } else if (isInserting) {
      context.missing(_letterMeta);
    }
    if (data.containsKey('digit')) {
      context.handle(
          _digitMeta, digit.isAcceptableOrUnknown(data['digit']!, _digitMeta));
    } else if (isInserting) {
      context.missing(_digitMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {letter};
  @override
  PriceCodeLetterRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PriceCodeLetterRow(
      letter: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}letter'])!,
      digit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}digit'])!,
    );
  }

  @override
  $PriceCodeLettersTable createAlias(String alias) {
    return $PriceCodeLettersTable(attachedDatabase, alias);
  }
}

class PriceCodeLetterRow extends DataClass
    implements Insertable<PriceCodeLetterRow> {
  final String letter;
  final int digit;
  const PriceCodeLetterRow({required this.letter, required this.digit});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['letter'] = Variable<String>(letter);
    map['digit'] = Variable<int>(digit);
    return map;
  }

  PriceCodeLettersCompanion toCompanion(bool nullToAbsent) {
    return PriceCodeLettersCompanion(
      letter: Value(letter),
      digit: Value(digit),
    );
  }

  factory PriceCodeLetterRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PriceCodeLetterRow(
      letter: serializer.fromJson<String>(json['letter']),
      digit: serializer.fromJson<int>(json['digit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'letter': serializer.toJson<String>(letter),
      'digit': serializer.toJson<int>(digit),
    };
  }

  PriceCodeLetterRow copyWith({String? letter, int? digit}) =>
      PriceCodeLetterRow(
        letter: letter ?? this.letter,
        digit: digit ?? this.digit,
      );
  PriceCodeLetterRow copyWithCompanion(PriceCodeLettersCompanion data) {
    return PriceCodeLetterRow(
      letter: data.letter.present ? data.letter.value : this.letter,
      digit: data.digit.present ? data.digit.value : this.digit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PriceCodeLetterRow(')
          ..write('letter: $letter, ')
          ..write('digit: $digit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(letter, digit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PriceCodeLetterRow &&
          other.letter == this.letter &&
          other.digit == this.digit);
}

class PriceCodeLettersCompanion extends UpdateCompanion<PriceCodeLetterRow> {
  final Value<String> letter;
  final Value<int> digit;
  final Value<int> rowid;
  const PriceCodeLettersCompanion({
    this.letter = const Value.absent(),
    this.digit = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PriceCodeLettersCompanion.insert({
    required String letter,
    required int digit,
    this.rowid = const Value.absent(),
  })  : letter = Value(letter),
        digit = Value(digit);
  static Insertable<PriceCodeLetterRow> custom({
    Expression<String>? letter,
    Expression<int>? digit,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (letter != null) 'letter': letter,
      if (digit != null) 'digit': digit,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PriceCodeLettersCompanion copyWith(
      {Value<String>? letter, Value<int>? digit, Value<int>? rowid}) {
    return PriceCodeLettersCompanion(
      letter: letter ?? this.letter,
      digit: digit ?? this.digit,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (letter.present) {
      map['letter'] = Variable<String>(letter.value);
    }
    if (digit.present) {
      map['digit'] = Variable<int>(digit.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PriceCodeLettersCompanion(')
          ..write('letter: $letter, ')
          ..write('digit: $digit, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $OneTimeDebtsTable oneTimeDebts = $OneTimeDebtsTable(this);
  late final $RecurringDebtsTable recurringDebts = $RecurringDebtsTable(this);
  late final $DebtOccurrencesTable debtOccurrences =
      $DebtOccurrencesTable(this);
  late final $ScheduledNotificationsTable scheduledNotifications =
      $ScheduledNotificationsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $PriceCodeLettersTable priceCodeLetters =
      $PriceCodeLettersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        oneTimeDebts,
        recurringDebts,
        debtOccurrences,
        scheduledNotifications,
        appSettings,
        priceCodeLetters
      ];
}

typedef $$OneTimeDebtsTableCreateCompanionBuilder = OneTimeDebtsCompanion
    Function({
  required String id,
  required String payee,
  required double amount,
  required DateTime dueDate,
  Value<String?> chequeNumber,
  Value<String?> paymentMethod,
  Value<String?> notes,
  Value<bool> isPaid,
  Value<DateTime?> paidAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$OneTimeDebtsTableUpdateCompanionBuilder = OneTimeDebtsCompanion
    Function({
  Value<String> id,
  Value<String> payee,
  Value<double> amount,
  Value<DateTime> dueDate,
  Value<String?> chequeNumber,
  Value<String?> paymentMethod,
  Value<String?> notes,
  Value<bool> isPaid,
  Value<DateTime?> paidAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$OneTimeDebtsTableFilterComposer
    extends Composer<_$AppDatabase, $OneTimeDebtsTable> {
  $$OneTimeDebtsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payee => $composableBuilder(
      column: $table.payee, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get chequeNumber => $composableBuilder(
      column: $table.chequeNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPaid => $composableBuilder(
      column: $table.isPaid, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
      column: $table.paidAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$OneTimeDebtsTableOrderingComposer
    extends Composer<_$AppDatabase, $OneTimeDebtsTable> {
  $$OneTimeDebtsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payee => $composableBuilder(
      column: $table.payee, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get chequeNumber => $composableBuilder(
      column: $table.chequeNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPaid => $composableBuilder(
      column: $table.isPaid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
      column: $table.paidAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$OneTimeDebtsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OneTimeDebtsTable> {
  $$OneTimeDebtsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get payee =>
      $composableBuilder(column: $table.payee, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get chequeNumber => $composableBuilder(
      column: $table.chequeNumber, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isPaid =>
      $composableBuilder(column: $table.isPaid, builder: (column) => column);

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$OneTimeDebtsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OneTimeDebtsTable,
    OneTimeDebtRow,
    $$OneTimeDebtsTableFilterComposer,
    $$OneTimeDebtsTableOrderingComposer,
    $$OneTimeDebtsTableAnnotationComposer,
    $$OneTimeDebtsTableCreateCompanionBuilder,
    $$OneTimeDebtsTableUpdateCompanionBuilder,
    (
      OneTimeDebtRow,
      BaseReferences<_$AppDatabase, $OneTimeDebtsTable, OneTimeDebtRow>
    ),
    OneTimeDebtRow,
    PrefetchHooks Function()> {
  $$OneTimeDebtsTableTableManager(_$AppDatabase db, $OneTimeDebtsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OneTimeDebtsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OneTimeDebtsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OneTimeDebtsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> payee = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<DateTime> dueDate = const Value.absent(),
            Value<String?> chequeNumber = const Value.absent(),
            Value<String?> paymentMethod = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isPaid = const Value.absent(),
            Value<DateTime?> paidAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OneTimeDebtsCompanion(
            id: id,
            payee: payee,
            amount: amount,
            dueDate: dueDate,
            chequeNumber: chequeNumber,
            paymentMethod: paymentMethod,
            notes: notes,
            isPaid: isPaid,
            paidAt: paidAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String payee,
            required double amount,
            required DateTime dueDate,
            Value<String?> chequeNumber = const Value.absent(),
            Value<String?> paymentMethod = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isPaid = const Value.absent(),
            Value<DateTime?> paidAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OneTimeDebtsCompanion.insert(
            id: id,
            payee: payee,
            amount: amount,
            dueDate: dueDate,
            chequeNumber: chequeNumber,
            paymentMethod: paymentMethod,
            notes: notes,
            isPaid: isPaid,
            paidAt: paidAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$OneTimeDebtsTable, OneTimeDebtRow>(table),
                    BaseReferences<_$AppDatabase, $OneTimeDebtsTable,
                        OneTimeDebtRow>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OneTimeDebtsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OneTimeDebtsTable,
    OneTimeDebtRow,
    $$OneTimeDebtsTableFilterComposer,
    $$OneTimeDebtsTableOrderingComposer,
    $$OneTimeDebtsTableAnnotationComposer,
    $$OneTimeDebtsTableCreateCompanionBuilder,
    $$OneTimeDebtsTableUpdateCompanionBuilder,
    (
      OneTimeDebtRow,
      BaseReferences<_$AppDatabase, $OneTimeDebtsTable, OneTimeDebtRow>
    ),
    OneTimeDebtRow,
    PrefetchHooks Function()>;
typedef $$RecurringDebtsTableCreateCompanionBuilder = RecurringDebtsCompanion
    Function({
  required String id,
  required String title,
  required String payee,
  required double defaultAmount,
  required FrequencyType frequencyType,
  Value<int?> intervalDays,
  Value<int?> dayOfMonth,
  required DateTime anchorDate,
  Value<String?> notes,
  Value<bool> isArchived,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$RecurringDebtsTableUpdateCompanionBuilder = RecurringDebtsCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<String> payee,
  Value<double> defaultAmount,
  Value<FrequencyType> frequencyType,
  Value<int?> intervalDays,
  Value<int?> dayOfMonth,
  Value<DateTime> anchorDate,
  Value<String?> notes,
  Value<bool> isArchived,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$RecurringDebtsTableReferences extends BaseReferences<
    _$AppDatabase, $RecurringDebtsTable, RecurringDebtRow> {
  $$RecurringDebtsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DebtOccurrencesTable, List<DebtOccurrenceRow>>
      _debtOccurrencesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.debtOccurrences,
              aliasName:
                  'recurring_debts__id__debt_occurrences__recurring_debt_id');

  $$DebtOccurrencesTableProcessedTableManager get debtOccurrencesRefs {
    final manager =
        $$DebtOccurrencesTableTableManager($_db, $_db.debtOccurrences).filter(
            (f) => f.recurringDebtId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_debtOccurrencesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RecurringDebtsTableFilterComposer
    extends Composer<_$AppDatabase, $RecurringDebtsTable> {
  $$RecurringDebtsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payee => $composableBuilder(
      column: $table.payee, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get defaultAmount => $composableBuilder(
      column: $table.defaultAmount, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<FrequencyType, FrequencyType, String>
      get frequencyType => $composableBuilder(
          column: $table.frequencyType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get intervalDays => $composableBuilder(
      column: $table.intervalDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dayOfMonth => $composableBuilder(
      column: $table.dayOfMonth, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get anchorDate => $composableBuilder(
      column: $table.anchorDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> debtOccurrencesRefs(
      Expression<bool> Function($$DebtOccurrencesTableFilterComposer f) f) {
    final $$DebtOccurrencesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.debtOccurrences,
        getReferencedColumn: (t) => t.recurringDebtId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DebtOccurrencesTableFilterComposer(
              $db: $db,
              $table: $db.debtOccurrences,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RecurringDebtsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecurringDebtsTable> {
  $$RecurringDebtsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payee => $composableBuilder(
      column: $table.payee, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get defaultAmount => $composableBuilder(
      column: $table.defaultAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frequencyType => $composableBuilder(
      column: $table.frequencyType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get intervalDays => $composableBuilder(
      column: $table.intervalDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dayOfMonth => $composableBuilder(
      column: $table.dayOfMonth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get anchorDate => $composableBuilder(
      column: $table.anchorDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$RecurringDebtsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecurringDebtsTable> {
  $$RecurringDebtsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get payee =>
      $composableBuilder(column: $table.payee, builder: (column) => column);

  GeneratedColumn<double> get defaultAmount => $composableBuilder(
      column: $table.defaultAmount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FrequencyType, String> get frequencyType =>
      $composableBuilder(
          column: $table.frequencyType, builder: (column) => column);

  GeneratedColumn<int> get intervalDays => $composableBuilder(
      column: $table.intervalDays, builder: (column) => column);

  GeneratedColumn<int> get dayOfMonth => $composableBuilder(
      column: $table.dayOfMonth, builder: (column) => column);

  GeneratedColumn<DateTime> get anchorDate => $composableBuilder(
      column: $table.anchorDate, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> debtOccurrencesRefs<T extends Object>(
      Expression<T> Function($$DebtOccurrencesTableAnnotationComposer a) f) {
    final $$DebtOccurrencesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.debtOccurrences,
        getReferencedColumn: (t) => t.recurringDebtId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DebtOccurrencesTableAnnotationComposer(
              $db: $db,
              $table: $db.debtOccurrences,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RecurringDebtsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RecurringDebtsTable,
    RecurringDebtRow,
    $$RecurringDebtsTableFilterComposer,
    $$RecurringDebtsTableOrderingComposer,
    $$RecurringDebtsTableAnnotationComposer,
    $$RecurringDebtsTableCreateCompanionBuilder,
    $$RecurringDebtsTableUpdateCompanionBuilder,
    (RecurringDebtRow, $$RecurringDebtsTableReferences),
    RecurringDebtRow,
    PrefetchHooks Function({bool debtOccurrencesRefs})> {
  $$RecurringDebtsTableTableManager(
      _$AppDatabase db, $RecurringDebtsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecurringDebtsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecurringDebtsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecurringDebtsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> payee = const Value.absent(),
            Value<double> defaultAmount = const Value.absent(),
            Value<FrequencyType> frequencyType = const Value.absent(),
            Value<int?> intervalDays = const Value.absent(),
            Value<int?> dayOfMonth = const Value.absent(),
            Value<DateTime> anchorDate = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RecurringDebtsCompanion(
            id: id,
            title: title,
            payee: payee,
            defaultAmount: defaultAmount,
            frequencyType: frequencyType,
            intervalDays: intervalDays,
            dayOfMonth: dayOfMonth,
            anchorDate: anchorDate,
            notes: notes,
            isArchived: isArchived,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String payee,
            required double defaultAmount,
            required FrequencyType frequencyType,
            Value<int?> intervalDays = const Value.absent(),
            Value<int?> dayOfMonth = const Value.absent(),
            required DateTime anchorDate,
            Value<String?> notes = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RecurringDebtsCompanion.insert(
            id: id,
            title: title,
            payee: payee,
            defaultAmount: defaultAmount,
            frequencyType: frequencyType,
            intervalDays: intervalDays,
            dayOfMonth: dayOfMonth,
            anchorDate: anchorDate,
            notes: notes,
            isArchived: isArchived,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$RecurringDebtsTable, RecurringDebtRow>(table),
                    $$RecurringDebtsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({debtOccurrencesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (debtOccurrencesRefs) db.debtOccurrences
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (debtOccurrencesRefs)
                    await $_getPrefetchedData<RecurringDebtRow,
                            $RecurringDebtsTable, DebtOccurrenceRow>(
                        currentTable: table,
                        referencedTable: $$RecurringDebtsTableReferences
                            ._debtOccurrencesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RecurringDebtsTableReferences(db, table, p0)
                                .debtOccurrencesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.recurringDebtId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RecurringDebtsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RecurringDebtsTable,
    RecurringDebtRow,
    $$RecurringDebtsTableFilterComposer,
    $$RecurringDebtsTableOrderingComposer,
    $$RecurringDebtsTableAnnotationComposer,
    $$RecurringDebtsTableCreateCompanionBuilder,
    $$RecurringDebtsTableUpdateCompanionBuilder,
    (RecurringDebtRow, $$RecurringDebtsTableReferences),
    RecurringDebtRow,
    PrefetchHooks Function({bool debtOccurrencesRefs})>;
typedef $$DebtOccurrencesTableCreateCompanionBuilder = DebtOccurrencesCompanion
    Function({
  required String id,
  required String recurringDebtId,
  required DateTime expectedDueDate,
  required double amount,
  Value<bool> isPaid,
  Value<DateTime?> paidAt,
  required int cycleIndex,
  Value<int> rowid,
});
typedef $$DebtOccurrencesTableUpdateCompanionBuilder = DebtOccurrencesCompanion
    Function({
  Value<String> id,
  Value<String> recurringDebtId,
  Value<DateTime> expectedDueDate,
  Value<double> amount,
  Value<bool> isPaid,
  Value<DateTime?> paidAt,
  Value<int> cycleIndex,
  Value<int> rowid,
});

final class $$DebtOccurrencesTableReferences extends BaseReferences<
    _$AppDatabase, $DebtOccurrencesTable, DebtOccurrenceRow> {
  $$DebtOccurrencesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $RecurringDebtsTable _recurringDebtIdTable(_$AppDatabase db) => db
      .recurringDebts
      .createAlias('debt_occurrences__recurring_debt_id__recurring_debts__id');

  $$RecurringDebtsTableProcessedTableManager get recurringDebtId {
    final $_column = $_itemColumn<String>('recurring_debt_id')!;

    final manager = $$RecurringDebtsTableTableManager($_db, $_db.recurringDebts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recurringDebtIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DebtOccurrencesTableFilterComposer
    extends Composer<_$AppDatabase, $DebtOccurrencesTable> {
  $$DebtOccurrencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expectedDueDate => $composableBuilder(
      column: $table.expectedDueDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPaid => $composableBuilder(
      column: $table.isPaid, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
      column: $table.paidAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cycleIndex => $composableBuilder(
      column: $table.cycleIndex, builder: (column) => ColumnFilters(column));

  $$RecurringDebtsTableFilterComposer get recurringDebtId {
    final $$RecurringDebtsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.recurringDebtId,
        referencedTable: $db.recurringDebts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RecurringDebtsTableFilterComposer(
              $db: $db,
              $table: $db.recurringDebts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DebtOccurrencesTableOrderingComposer
    extends Composer<_$AppDatabase, $DebtOccurrencesTable> {
  $$DebtOccurrencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expectedDueDate => $composableBuilder(
      column: $table.expectedDueDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPaid => $composableBuilder(
      column: $table.isPaid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
      column: $table.paidAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cycleIndex => $composableBuilder(
      column: $table.cycleIndex, builder: (column) => ColumnOrderings(column));

  $$RecurringDebtsTableOrderingComposer get recurringDebtId {
    final $$RecurringDebtsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.recurringDebtId,
        referencedTable: $db.recurringDebts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RecurringDebtsTableOrderingComposer(
              $db: $db,
              $table: $db.recurringDebts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DebtOccurrencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DebtOccurrencesTable> {
  $$DebtOccurrencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get expectedDueDate => $composableBuilder(
      column: $table.expectedDueDate, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<bool> get isPaid =>
      $composableBuilder(column: $table.isPaid, builder: (column) => column);

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);

  GeneratedColumn<int> get cycleIndex => $composableBuilder(
      column: $table.cycleIndex, builder: (column) => column);

  $$RecurringDebtsTableAnnotationComposer get recurringDebtId {
    final $$RecurringDebtsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.recurringDebtId,
        referencedTable: $db.recurringDebts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RecurringDebtsTableAnnotationComposer(
              $db: $db,
              $table: $db.recurringDebts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DebtOccurrencesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DebtOccurrencesTable,
    DebtOccurrenceRow,
    $$DebtOccurrencesTableFilterComposer,
    $$DebtOccurrencesTableOrderingComposer,
    $$DebtOccurrencesTableAnnotationComposer,
    $$DebtOccurrencesTableCreateCompanionBuilder,
    $$DebtOccurrencesTableUpdateCompanionBuilder,
    (DebtOccurrenceRow, $$DebtOccurrencesTableReferences),
    DebtOccurrenceRow,
    PrefetchHooks Function({bool recurringDebtId})> {
  $$DebtOccurrencesTableTableManager(
      _$AppDatabase db, $DebtOccurrencesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DebtOccurrencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DebtOccurrencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DebtOccurrencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> recurringDebtId = const Value.absent(),
            Value<DateTime> expectedDueDate = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<bool> isPaid = const Value.absent(),
            Value<DateTime?> paidAt = const Value.absent(),
            Value<int> cycleIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DebtOccurrencesCompanion(
            id: id,
            recurringDebtId: recurringDebtId,
            expectedDueDate: expectedDueDate,
            amount: amount,
            isPaid: isPaid,
            paidAt: paidAt,
            cycleIndex: cycleIndex,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String recurringDebtId,
            required DateTime expectedDueDate,
            required double amount,
            Value<bool> isPaid = const Value.absent(),
            Value<DateTime?> paidAt = const Value.absent(),
            required int cycleIndex,
            Value<int> rowid = const Value.absent(),
          }) =>
              DebtOccurrencesCompanion.insert(
            id: id,
            recurringDebtId: recurringDebtId,
            expectedDueDate: expectedDueDate,
            amount: amount,
            isPaid: isPaid,
            paidAt: paidAt,
            cycleIndex: cycleIndex,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$DebtOccurrencesTable, DebtOccurrenceRow>(
                        table),
                    $$DebtOccurrencesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({recurringDebtId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (recurringDebtId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.recurringDebtId,
                    referencedTable: $$DebtOccurrencesTableReferences
                        ._recurringDebtIdTable(db),
                    referencedColumn: $$DebtOccurrencesTableReferences
                        ._recurringDebtIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DebtOccurrencesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DebtOccurrencesTable,
    DebtOccurrenceRow,
    $$DebtOccurrencesTableFilterComposer,
    $$DebtOccurrencesTableOrderingComposer,
    $$DebtOccurrencesTableAnnotationComposer,
    $$DebtOccurrencesTableCreateCompanionBuilder,
    $$DebtOccurrencesTableUpdateCompanionBuilder,
    (DebtOccurrenceRow, $$DebtOccurrencesTableReferences),
    DebtOccurrenceRow,
    PrefetchHooks Function({bool recurringDebtId})>;
typedef $$ScheduledNotificationsTableCreateCompanionBuilder
    = ScheduledNotificationsCompanion Function({
  Value<int> notificationId,
  required DebtKind debtType,
  required String referenceId,
  required ReminderOffset offsetLabel,
  required DateTime scheduledFor,
});
typedef $$ScheduledNotificationsTableUpdateCompanionBuilder
    = ScheduledNotificationsCompanion Function({
  Value<int> notificationId,
  Value<DebtKind> debtType,
  Value<String> referenceId,
  Value<ReminderOffset> offsetLabel,
  Value<DateTime> scheduledFor,
});

class $$ScheduledNotificationsTableFilterComposer
    extends Composer<_$AppDatabase, $ScheduledNotificationsTable> {
  $$ScheduledNotificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get notificationId => $composableBuilder(
      column: $table.notificationId,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<DebtKind, DebtKind, String> get debtType =>
      $composableBuilder(
          column: $table.debtType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get referenceId => $composableBuilder(
      column: $table.referenceId, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ReminderOffset, ReminderOffset, String>
      get offsetLabel => $composableBuilder(
          column: $table.offsetLabel,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get scheduledFor => $composableBuilder(
      column: $table.scheduledFor, builder: (column) => ColumnFilters(column));
}

class $$ScheduledNotificationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ScheduledNotificationsTable> {
  $$ScheduledNotificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get notificationId => $composableBuilder(
      column: $table.notificationId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get debtType => $composableBuilder(
      column: $table.debtType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get referenceId => $composableBuilder(
      column: $table.referenceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get offsetLabel => $composableBuilder(
      column: $table.offsetLabel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get scheduledFor => $composableBuilder(
      column: $table.scheduledFor,
      builder: (column) => ColumnOrderings(column));
}

class $$ScheduledNotificationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScheduledNotificationsTable> {
  $$ScheduledNotificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get notificationId => $composableBuilder(
      column: $table.notificationId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DebtKind, String> get debtType =>
      $composableBuilder(column: $table.debtType, builder: (column) => column);

  GeneratedColumn<String> get referenceId => $composableBuilder(
      column: $table.referenceId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReminderOffset, String> get offsetLabel =>
      $composableBuilder(
          column: $table.offsetLabel, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledFor => $composableBuilder(
      column: $table.scheduledFor, builder: (column) => column);
}

class $$ScheduledNotificationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ScheduledNotificationsTable,
    ScheduledNotificationRow,
    $$ScheduledNotificationsTableFilterComposer,
    $$ScheduledNotificationsTableOrderingComposer,
    $$ScheduledNotificationsTableAnnotationComposer,
    $$ScheduledNotificationsTableCreateCompanionBuilder,
    $$ScheduledNotificationsTableUpdateCompanionBuilder,
    (
      ScheduledNotificationRow,
      BaseReferences<_$AppDatabase, $ScheduledNotificationsTable,
          ScheduledNotificationRow>
    ),
    ScheduledNotificationRow,
    PrefetchHooks Function()> {
  $$ScheduledNotificationsTableTableManager(
      _$AppDatabase db, $ScheduledNotificationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScheduledNotificationsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$ScheduledNotificationsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScheduledNotificationsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> notificationId = const Value.absent(),
            Value<DebtKind> debtType = const Value.absent(),
            Value<String> referenceId = const Value.absent(),
            Value<ReminderOffset> offsetLabel = const Value.absent(),
            Value<DateTime> scheduledFor = const Value.absent(),
          }) =>
              ScheduledNotificationsCompanion(
            notificationId: notificationId,
            debtType: debtType,
            referenceId: referenceId,
            offsetLabel: offsetLabel,
            scheduledFor: scheduledFor,
          ),
          createCompanionCallback: ({
            Value<int> notificationId = const Value.absent(),
            required DebtKind debtType,
            required String referenceId,
            required ReminderOffset offsetLabel,
            required DateTime scheduledFor,
          }) =>
              ScheduledNotificationsCompanion.insert(
            notificationId: notificationId,
            debtType: debtType,
            referenceId: referenceId,
            offsetLabel: offsetLabel,
            scheduledFor: scheduledFor,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$ScheduledNotificationsTable,
                        ScheduledNotificationRow>(table),
                    BaseReferences<_$AppDatabase, $ScheduledNotificationsTable,
                        ScheduledNotificationRow>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ScheduledNotificationsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ScheduledNotificationsTable,
        ScheduledNotificationRow,
        $$ScheduledNotificationsTableFilterComposer,
        $$ScheduledNotificationsTableOrderingComposer,
        $$ScheduledNotificationsTableAnnotationComposer,
        $$ScheduledNotificationsTableCreateCompanionBuilder,
        $$ScheduledNotificationsTableUpdateCompanionBuilder,
        (
          ScheduledNotificationRow,
          BaseReferences<_$AppDatabase, $ScheduledNotificationsTable,
              ScheduledNotificationRow>
        ),
        ScheduledNotificationRow,
        PrefetchHooks Function()>;
typedef $$AppSettingsTableCreateCompanionBuilder = AppSettingsCompanion
    Function({
  Value<int> id,
  Value<String> currencyCode,
});
typedef $$AppSettingsTableUpdateCompanionBuilder = AppSettingsCompanion
    Function({
  Value<int> id,
  Value<String> currencyCode,
});

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currencyCode => $composableBuilder(
      column: $table.currencyCode, builder: (column) => ColumnFilters(column));
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currencyCode => $composableBuilder(
      column: $table.currencyCode,
      builder: (column) => ColumnOrderings(column));
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get currencyCode => $composableBuilder(
      column: $table.currencyCode, builder: (column) => column);
}

class $$AppSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSettingRow,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableAnnotationComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder,
    (
      AppSettingRow,
      BaseReferences<_$AppDatabase, $AppSettingsTable, AppSettingRow>
    ),
    AppSettingRow,
    PrefetchHooks Function()> {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> currencyCode = const Value.absent(),
          }) =>
              AppSettingsCompanion(
            id: id,
            currencyCode: currencyCode,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> currencyCode = const Value.absent(),
          }) =>
              AppSettingsCompanion.insert(
            id: id,
            currencyCode: currencyCode,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$AppSettingsTable, AppSettingRow>(table),
                    BaseReferences<_$AppDatabase, $AppSettingsTable,
                        AppSettingRow>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppSettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSettingRow,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableAnnotationComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder,
    (
      AppSettingRow,
      BaseReferences<_$AppDatabase, $AppSettingsTable, AppSettingRow>
    ),
    AppSettingRow,
    PrefetchHooks Function()>;
typedef $$PriceCodeLettersTableCreateCompanionBuilder
    = PriceCodeLettersCompanion Function({
  required String letter,
  required int digit,
  Value<int> rowid,
});
typedef $$PriceCodeLettersTableUpdateCompanionBuilder
    = PriceCodeLettersCompanion Function({
  Value<String> letter,
  Value<int> digit,
  Value<int> rowid,
});

class $$PriceCodeLettersTableFilterComposer
    extends Composer<_$AppDatabase, $PriceCodeLettersTable> {
  $$PriceCodeLettersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get letter => $composableBuilder(
      column: $table.letter, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get digit => $composableBuilder(
      column: $table.digit, builder: (column) => ColumnFilters(column));
}

class $$PriceCodeLettersTableOrderingComposer
    extends Composer<_$AppDatabase, $PriceCodeLettersTable> {
  $$PriceCodeLettersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get letter => $composableBuilder(
      column: $table.letter, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get digit => $composableBuilder(
      column: $table.digit, builder: (column) => ColumnOrderings(column));
}

class $$PriceCodeLettersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PriceCodeLettersTable> {
  $$PriceCodeLettersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get letter =>
      $composableBuilder(column: $table.letter, builder: (column) => column);

  GeneratedColumn<int> get digit =>
      $composableBuilder(column: $table.digit, builder: (column) => column);
}

class $$PriceCodeLettersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PriceCodeLettersTable,
    PriceCodeLetterRow,
    $$PriceCodeLettersTableFilterComposer,
    $$PriceCodeLettersTableOrderingComposer,
    $$PriceCodeLettersTableAnnotationComposer,
    $$PriceCodeLettersTableCreateCompanionBuilder,
    $$PriceCodeLettersTableUpdateCompanionBuilder,
    (
      PriceCodeLetterRow,
      BaseReferences<_$AppDatabase, $PriceCodeLettersTable, PriceCodeLetterRow>
    ),
    PriceCodeLetterRow,
    PrefetchHooks Function()> {
  $$PriceCodeLettersTableTableManager(
      _$AppDatabase db, $PriceCodeLettersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PriceCodeLettersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PriceCodeLettersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PriceCodeLettersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> letter = const Value.absent(),
            Value<int> digit = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PriceCodeLettersCompanion(
            letter: letter,
            digit: digit,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String letter,
            required int digit,
            Value<int> rowid = const Value.absent(),
          }) =>
              PriceCodeLettersCompanion.insert(
            letter: letter,
            digit: digit,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$PriceCodeLettersTable, PriceCodeLetterRow>(
                        table),
                    BaseReferences<_$AppDatabase, $PriceCodeLettersTable,
                        PriceCodeLetterRow>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PriceCodeLettersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PriceCodeLettersTable,
    PriceCodeLetterRow,
    $$PriceCodeLettersTableFilterComposer,
    $$PriceCodeLettersTableOrderingComposer,
    $$PriceCodeLettersTableAnnotationComposer,
    $$PriceCodeLettersTableCreateCompanionBuilder,
    $$PriceCodeLettersTableUpdateCompanionBuilder,
    (
      PriceCodeLetterRow,
      BaseReferences<_$AppDatabase, $PriceCodeLettersTable, PriceCodeLetterRow>
    ),
    PriceCodeLetterRow,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$OneTimeDebtsTableTableManager get oneTimeDebts =>
      $$OneTimeDebtsTableTableManager(_db, _db.oneTimeDebts);
  $$RecurringDebtsTableTableManager get recurringDebts =>
      $$RecurringDebtsTableTableManager(_db, _db.recurringDebts);
  $$DebtOccurrencesTableTableManager get debtOccurrences =>
      $$DebtOccurrencesTableTableManager(_db, _db.debtOccurrences);
  $$ScheduledNotificationsTableTableManager get scheduledNotifications =>
      $$ScheduledNotificationsTableTableManager(
          _db, _db.scheduledNotifications);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$PriceCodeLettersTableTableManager get priceCodeLetters =>
      $$PriceCodeLettersTableTableManager(_db, _db.priceCodeLetters);
}
