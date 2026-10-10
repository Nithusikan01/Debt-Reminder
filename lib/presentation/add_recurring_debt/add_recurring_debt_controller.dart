import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/enums/frequency_type.dart';
import '../../data/providers.dart';

class AddRecurringDebtController {
  final Ref ref;

  AddRecurringDebtController(this.ref);

  Future<void> submit({
    required String title,
    required String payee,
    required double defaultAmount,
    required FrequencyType frequencyType,
    int? intervalDays,
    int? dayOfMonth,
    required DateTime anchorDate,
    String? notes,
  }) async {
    final currencyCode = await ref.read(settingsRepositoryProvider).getCurrencyCode();
    await ref.read(recurringDebtRepositoryProvider).create(
          title: title,
          payee: payee,
          defaultAmount: defaultAmount,
          frequencyType: frequencyType,
          intervalDays: intervalDays,
          dayOfMonth: dayOfMonth,
          anchorDate: anchorDate,
          notes: notes,
          currencyCode: currencyCode,
        );
  }
}

final addRecurringDebtControllerProvider = Provider<AddRecurringDebtController>((ref) {
  return AddRecurringDebtController(ref);
});
