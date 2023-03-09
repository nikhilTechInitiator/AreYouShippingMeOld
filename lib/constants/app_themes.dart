import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData getTheme(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;



  return ThemeData.light().copyWith(

    colorScheme: const ColorScheme(
      primary: AppColors.primary,
      secondary: Color(0xFF03DAC6),
      surface: Color(0xFFFFFFFF),
      background: Color(0xFFF5F5F5),
      error: Color(0xFFB00020),
      onPrimary: AppColors.onPrimary,
      onSecondary: Color(0xFF000000),
      onSurface: Color(0xFF000000),
      onBackground: Color(0xFF000000),
      onError: Color(0xFFFFFFFF),
      brightness: Brightness.light,
    ),
  );
}
