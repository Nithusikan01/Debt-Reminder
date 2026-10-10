import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers.dart';
import '../../domain/models/one_time_debt.dart';
import '../../data/repositories/recurring_debt_repository.dart';

final oneTimeDebtByIdProvider =
    StreamProvider.family<OneTimeDebt?, String>((ref, id) {
  return ref.watch(oneTimeDebtRepositoryProvider).watchById(id);
});

final occurrenceByIdProvider =
    StreamProvider.family<DebtOccurrenceWithParent?, String>((ref, id) {
  return ref.watch(recurringDebtRepositoryProvider).watchOccurrenceById(id);
});

class DebtDetailController {
  final Ref ref;

  DebtDetailController(this.ref);

  Future<void> markOneTimePaid(String id) {
    return ref.read(oneTimeDebtRepositoryProvider).markPaid(id);
  }

  Future<void> deleteOneTime(String id) {
    return ref.read(oneTimeDebtRepositoryProvider).delete(id);
  }

  Future<void> markOccurrencePaid(String occurrenceId) async {
    final currencyCode = await ref.read(settingsRepositoryProvider).getCurrencyCode();
    return ref
        .read(recurringDebtRepositoryProvider)
        .markOccurrencePaid(occurrenceId, currencyCode: currencyCode);
  }

  Future<void> archiveRecurring(String recurringDebtId) {
    return ref.read(recurringDebtRepositoryProvider).archive(recurringDebtId);
  }
}

final debtDetailControllerProvider = Provider<DebtDetailController>((ref) {
  return DebtDetailController(ref);
});
