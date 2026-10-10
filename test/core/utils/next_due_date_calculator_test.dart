import 'package:flutter_test/flutter_test.dart';
import 'package:debt_reminder/core/enums/frequency_type.dart';
import 'package:debt_reminder/core/utils/next_due_date_calculator.dart';

void main() {
  group('computeNextExpectedDate', () {
    test('daily adds exactly one day', () {
      final result = computeNextExpectedDate(
        previousExpectedDate: DateTime(2026, 9, 16),
        type: FrequencyType.daily,
      );
      expect(result, DateTime(2026, 9, 17));
    });

    test('customIntervalDays adds the given number of days', () {
      final result = computeNextExpectedDate(
        previousExpectedDate: DateTime(2026, 9, 16),
        type: FrequencyType.customIntervalDays,
        intervalDays: 10,
      );
      expect(result, DateTime(2026, 9, 26));
    });

    test('monthlyOnDay advances to the same day next month', () {
      final result = computeNextExpectedDate(
        previousExpectedDate: DateTime(2026, 9, 5),
        type: FrequencyType.monthlyOnDay,
        dayOfMonth: 5,
      );
      expect(result, DateTime(2026, 10, 5));
    });

    test('monthlyOnDay clamps day 31 into a shorter month (April has 30 days)', () {
      final result = computeNextExpectedDate(
        previousExpectedDate: DateTime(2026, 3, 31),
        type: FrequencyType.monthlyOnDay,
        dayOfMonth: 31,
      );
      expect(result, DateTime(2026, 4, 30));
    });

    test('monthlyOnDay clamps day 30 into February on a non-leap year', () {
      final result = computeNextExpectedDate(
        previousExpectedDate: DateTime(2026, 1, 30),
        type: FrequencyType.monthlyOnDay,
        dayOfMonth: 30,
      );
      expect(result, DateTime(2026, 2, 28));
    });

    test('monthlyOnDay clamps day 30 into February on a leap year', () {
      final result = computeNextExpectedDate(
        previousExpectedDate: DateTime(2028, 1, 30),
        type: FrequencyType.monthlyOnDay,
        dayOfMonth: 30,
      );
      expect(result, DateTime(2028, 2, 29));
    });

    test('monthlyOnDay rolls over the year boundary', () {
      final result = computeNextExpectedDate(
        previousExpectedDate: DateTime(2026, 12, 5),
        type: FrequencyType.monthlyOnDay,
        dayOfMonth: 5,
      );
      expect(result, DateTime(2027, 1, 5));
    });

    test('late payment does not shift the schedule: next due date ignores paid date', () {
      // Rent due monthly on the 5th, expected due 2026-09-05, but paid late
      // on 2026-09-09. The calculator must only ever see the expected date.
      final expectedDue = DateTime(2026, 9, 5);
      final result = computeNextExpectedDate(
        previousExpectedDate: expectedDue,
        type: FrequencyType.monthlyOnDay,
        dayOfMonth: 5,
      );
      expect(result, DateTime(2026, 10, 5));
      expect(result, isNot(DateTime(2026, 10, 9)));
    });
  });
}
