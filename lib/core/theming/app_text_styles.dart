import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Fraunces for display/headings, Space Grotesk for body/UI text —
/// matching the app's design canvas.
class AppText {
  AppText._();

  static TextStyle display({
    double size = 26,
    FontWeight weight = FontWeight.w600,
    Color color = AppColors.text,
    double? height,
  }) =>
      GoogleFonts.fraunces(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
      );

  static TextStyle body({
    double size = 14,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.text,
    double? height,
  }) =>
      GoogleFonts.spaceGrotesk(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
      );
}
