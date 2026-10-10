import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers.dart';
import '../../domain/models/dashboard_item.dart';

final historyItemsProvider = StreamProvider<List<DashboardItem>>((ref) {
  return ref.watch(dashboardRepositoryProvider).watchHistory();
});
