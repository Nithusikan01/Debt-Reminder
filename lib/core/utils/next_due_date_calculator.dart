import '../enums/frequency_type.dart';

/// Computes the next expected due date for a recurring debt.
///
/// The result is always derived from [previousExpectedDate] — the
/// originally scheduled date — never from when the debt was actually paid.
/// This keeps late payments from shifting the whole future schedule: rent
/// due on the 5th that gets paid on the 9th is still due on the 5th next
/// month, not the 9th.
DateTime computeNextExpectedDate({
  required DateTime previousExpectedDate,
  required FrequencyType type,
  int? intervalDays,
  int? dayOfMonth,
}) {
  switch (type) {
    case FrequencyType.daily:
      return previousExpectedDate.add(const Duration(days: 1));

    case FrequencyType.customIntervalDays:
      assert(intervalDays != null && intervalDays > 0,
          'intervalDays must be provided and positive for customIntervalDays');
      return previousExpectedDate.add(Duration(days: intervalDays!));

    case FrequencyType.monthlyOnDay:
      assert(dayOfMonth != null && dayOfMonth >= 1 && dayOfMonth <= 31,
          'dayOfMonth must be 1-31 for monthlyOnDay');
      final nextMonthFirst = DateTime(
        previousExpectedDate.year,
        previousExpectedDate.month + 1,
        1,
      );
      final lastDayOfNextMonth =
          DateTime(nextMonthFirst.year, nextMonthFirst.month + 1, 0).day;
      final clampedDay = dayOfMonth!.clamp(1, lastDayOfNextMonth);
      return DateTime(nextMonthFirst.year, nextMonthFirst.month, clampedDay);
  }
}
