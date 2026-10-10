import 'package:flutter/material.dart';

/// Design tokens matching the app's published design canvas.
class AppColors {
  AppColors._();

  static const bg = Color(0xFFFAF7F2);
  static const surface = Color(0xFFFFFFFF);
  static const border = Color(0xFFE6DFD3);

  static const text = Color(0xFF221F1A);
  static const text2 = Color(0xFF6B6459);
  static const text3 = Color(0xFF9B9384);

  static const brand = Color(0xFF1F6F5C);
  static const brandSoft = Color(0xFFEAF2EE);
  static const brandOn = Color(0xFFCFE3DB);
  static const brandDark = Color(0xFF2E5B4C);

  static const danger = Color(0xFFC1442C);
  static const dangerText = Color(0xFFA83A22);
  static const dangerSoft = Color(0xFFF7E4DE);
  static const dangerBorder = Color(0xFFECC7BB);

  static const warnText = Color(0xFF7C5316);
  static const warnSoft = Color(0xFFF6ECD9);

  static const infoText = Color(0xFF3F5A76);
  static const infoSoft = Color(0xFFE6ECF2);

  /// Returns the (background, text) colors for an urgency badge given the
  /// number of days until due (negative = overdue).
  static (Color bg, Color fg) urgencyBadgeColors(int daysUntilDue) {
    if (daysUntilDue < 0) return (danger, Colors.white);
    if (daysUntilDue <= 1) return (dangerSoft, dangerText);
    if (daysUntilDue <= 3) return (warnSoft, warnText);
    return (infoSoft, infoText);
  }

  static String urgencyBadgeLabel(int daysUntilDue) {
    if (daysUntilDue < 0) return 'Overdue';
    if (daysUntilDue == 0) return 'Due today';
    if (daysUntilDue == 1) return '1 day';
    return '$daysUntilDue days';
  }
}
