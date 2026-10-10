import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers.dart';

class SettingsController {
  final Ref ref;

  SettingsController(this.ref);

  Future<void> setCurrencyCode(String currencyCode) {
    return ref.read(settingsRepositoryProvider).setCurrencyCode(currencyCode);
  }
}

final settingsControllerProvider = Provider<SettingsController>((ref) {
  return SettingsController(ref);
});
