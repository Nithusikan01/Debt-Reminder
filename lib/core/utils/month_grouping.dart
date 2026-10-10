import 'package:intl/intl.dart';

import '../../domain/models/dashboard_item.dart';

/// All [DashboardItem]s due in one calendar month, with their combined total.
class MonthGroup {
  final String key; // "yyyy-MM", sorts chronologically as a string
  final String label; // "September 2026"
  final String shortLabel; // "Sep"
  final double total;
  final List<DashboardItem> items;

  const MonthGroup({
    required this.key,
    required this.label,
    required this.shortLabel,
    required this.total,
    required this.items,
  });
}

/// Groups items by due-date month, sorted chronologically. Assumes [items]
/// is already sorted by due date (as the dashboard/history streams provide).
List<MonthGroup> groupByMonth(List<DashboardItem> items) {
  final byKey = <String, List<DashboardItem>>{};
  for (final item in items) {
    final key =
        '${item.dueDate.year.toString().padLeft(4, '0')}-${item.dueDate.month.toString().padLeft(2, '0')}';
    byKey.putIfAbsent(key, () => []).add(item);
  }

  final sortedKeys = byKey.keys.toList()..sort();
  return sortedKeys.map((key) {
    final groupItems = byKey[key]!;
    final total = groupItems.fold<double>(0, (sum, i) => sum + i.amount);
    final dueDate = groupItems.first.dueDate;
    return MonthGroup(
      key: key,
      label: DateFormat('MMMM yyyy').format(dueDate),
      shortLabel: DateFormat('MMM').format(dueDate),
      total: total,
      items: groupItems,
    );
  }).toList();
}
