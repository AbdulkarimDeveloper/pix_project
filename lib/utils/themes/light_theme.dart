import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixa_project/utils/constants.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Constants.appColor,
    // ignore: deprecated_member_use
    // primaryColorBrightness: Brightness.light,
    // ignore: deprecated_member_use
    // accentColor: Constants.appColor,
    scrollbarTheme: ScrollbarThemeData(
      // thumbVisibility: false,
      thickness: MaterialStateProperty.all(12),
      interactive: true,
      thumbColor: MaterialStateProperty.all(
        Constants.appColor.withOpacity(0.3),
      ),
      radius: const Radius.circular(10),
      minThumbLength: 100,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Constants.appColor,
      selectionColor: Constants.appColor.withOpacity(0.5),
      selectionHandleColor: Constants.appColor.withOpacity(0.5),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat(
        fontSize: 96.0,
        fontWeight: FontWeight.w400,
      ),
      displayMedium: GoogleFonts.montserrat(
        fontSize: 60.0,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: GoogleFonts.montserrat(
        fontSize: 48.0,
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: GoogleFonts.montserrat(
        fontSize: 48.0,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: GoogleFonts.montserrat(
        fontSize: 34.0,
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: GoogleFonts.montserrat(
        fontSize: 24.0,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: GoogleFonts.montserrat(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.montserrat(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.montserrat(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.montserrat(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: GoogleFonts.montserrat(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: GoogleFonts.montserrat(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: GoogleFonts.montserrat(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: GoogleFonts.montserrat(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.montserrat(
        fontSize: 10.0,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
