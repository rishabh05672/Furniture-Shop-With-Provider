import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  // Colors
  static const Color primaryColor = Color(0xFFFFB800);
  static const Color secondaryColor = Color(0xFF1A1A1A);
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Color(0xFF1A1A1A);
  static const Color greyColor = Color(0xFFF5F5F5);

  // Text Styles
  static TextStyle get headingStyle => GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static TextStyle get titleStyle => GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static TextStyle get bodyStyle =>
      GoogleFonts.poppins(fontSize: 16, color: textColor);

  // Padding
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  // Border Radius
  static const double defaultBorderRadius = 12.0;
  static const double smallBorderRadius = 8.0;
  static const double largeBorderRadius = 16.0;

  // Animation Duration
  static const Duration defaultDuration = Duration(milliseconds: 300);
}
