import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perfect_feed/app/theme/app_colors.dart';

class AppTextStyles {
  static TextStyle body = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.blackMain,
  );

  static TextStyle title = GoogleFonts.lato(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.blackMain,
  );

  static TextStyle headline = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.blackMain,
  );

  static TextStyle footnote = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.blackMain,
  );

  static TextStyle caption = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.blackSecondary,
  );
}
