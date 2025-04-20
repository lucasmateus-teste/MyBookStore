import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';

class AppTheme {
  AppTheme._();

  // static ThemeData get theme => ThemeData.light(useMaterial3: true);
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.i.primary.df,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.i.grayScale.bg,
  );
}
