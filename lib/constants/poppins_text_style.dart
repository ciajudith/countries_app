import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PoppinsTextStyle {
  static TextStyle regular = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontWeight: FontWeight.w400,
  );

  static TextStyle medium = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static TextStyle semiBold = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontWeight: FontWeight.w600,
  );

  static TextStyle bold = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontWeight: FontWeight.w700,
  );
}
