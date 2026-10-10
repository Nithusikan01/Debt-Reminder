import 'package:intl/intl.dart';

import '../constants/currency_presets.dart';

String formatDueDate(DateTime date) => DateFormat('d MMM yyyy').format(date);

String formatAmount(double amount, String currencyCode) {
  final symbol = currencySymbols[currencyCode] ?? currencyCode;
  final number = NumberFormat('#,##0.00').format(amount);
  return '$symbol $number';
}
