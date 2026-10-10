/// The four reminder points scheduled relative to a debt's due date.
enum ReminderOffset {
  sevenDaysBefore,
  fiveDaysBefore,
  threeDaysBefore,
  oneDayBefore,
}

extension ReminderOffsetTiming on ReminderOffset {
  /// Days to subtract from the due date to get the reminder's calendar date.
  int get daysBeforeDue {
    switch (this) {
      case ReminderOffset.sevenDaysBefore:
        return 7;
      case ReminderOffset.fiveDaysBefore:
        return 5;
      case ReminderOffset.threeDaysBefore:
        return 3;
      case ReminderOffset.oneDayBefore:
        return 1;
    }
  }

  /// Local hour the reminder fires at.
  int get hourOfDay => 9;
}
