import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: const Color(0xFFFFB800),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFFB800),
      primary: const Color(0xFFFFB800),
      secondary: const Color(0xFF1A1A1A),
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1A1A1A),
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1A1A1A),
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        color: const Color(0xFF1A1A1A),
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        color: const Color(0xFF1A1A1A),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}
