import 'package:flutter_test/flutter_test.dart';
import 'package:debt_reminder/core/enums/debt_kind.dart';
import 'package:debt_reminder/core/utils/month_grouping.dart';
import 'package:debt_reminder/domain/models/dashboard_item.dart';

DashboardItem _item({required DateTime dueDate, required double amount, String payee = 'Someone'}) {
  return DashboardItem(
    referenceId: payee,
    kind: DebtKind.oneTime,
    title: 'Payment',
    payee: payee,
    amount: amount,
    dueDate: dueDate,
    isPaid: false,
  );
}

void main() {
  group('groupByMonth', () {
    test('groups items by due-date month and sums each group total', () {
      final items = [
        _item(dueDate: DateTime(2026, 9, 21), amount: 18500, payee: 'Perera'),
        _item(dueDate: DateTime(2026, 9, 24), amount: 25000, payee: 'Silva'),
        _item(dueDate: DateTime(2026, 10, 5), amount: 4200, payee: 'CEB'),
        _item(dueDate: DateTime(2026, 10, 12), amount: 1150, payee: 'NWSDB'),
        _item(dueDate: DateTime(2026, 11, 2), amount: 1000, payee: 'Chit Co'),
      ];

      final groups = groupByMonth(items);

      expect(groups.length, 3);
      expect(groups[0].key, '2026-09');
      expect(groups[0].total, 43500);
      expect(groups[0].items.length, 2);
      expect(groups[1].key, '2026-10');
      expect(groups[1].total, 5350);
      expect(groups[2].key, '2026-11');
      expect(groups[2].total, 1000);
    });

    test('sorts groups chronologically even when items are out of order', () {
      final items = [
        _item(dueDate: DateTime(2027, 1, 5), amount: 100),
        _item(dueDate: DateTime(2026, 12, 5), amount: 200),
        _item(dueDate: DateTime(2026, 6, 5), amount: 300),
      ];

      final groups = groupByMonth(items);

      expect(groups.map((g) => g.key).toList(), ['2026-06', '2026-12', '2027-01']);
    });

    test('returns an empty list for no items', () {
      expect(groupByMonth(const []), isEmpty);
    });
  });
}
