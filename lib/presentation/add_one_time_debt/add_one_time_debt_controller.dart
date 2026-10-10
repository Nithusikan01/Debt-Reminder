import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers.dart';

class AddOneTimeDebtController {
  final Ref ref;

  AddOneTimeDebtController(this.ref);

  Future<void> submit({
    required String payee,
    required double amount,
    required DateTime dueDate,
    String? chequeNumber,
    String? paymentMethod,
    String? notes,
  }) async {
    final currencyCode = await ref.read(settingsRepositoryProvider).getCurrencyCode();
    await ref.read(oneTimeDebtRepositoryProvider).create(
          payee: payee,
          amount: amount,
          dueDate: dueDate,
          chequeNumber: chequeNumber,
          paymentMethod: paymentMethod,
          notes: notes,
          currencyCode: currencyCode,
        );
  }
}

final addOneTimeDebtControllerProvider = Provider<AddOneTimeDebtController>((ref) {
  return AddOneTimeDebtController(ref);
});
