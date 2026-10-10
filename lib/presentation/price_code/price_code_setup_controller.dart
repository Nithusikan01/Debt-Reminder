import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers.dart';

class PriceCodeSetupController {
  final Ref ref;

  PriceCodeSetupController(this.ref);

  Future<void> assignLetter(String letter, int digit) {
    return ref.read(priceCodeRepositoryProvider).assignLetter(letter, digit);
  }

  Future<void> removeLetter(String letter) {
    return ref.read(priceCodeRepositoryProvider).removeLetter(letter);
  }

  Future<void> resetAll() {
    return ref.read(priceCodeRepositoryProvider).resetAll();
  }
}

final priceCodeSetupControllerProvider = Provider<PriceCodeSetupController>((ref) {
  return PriceCodeSetupController(ref);
});
