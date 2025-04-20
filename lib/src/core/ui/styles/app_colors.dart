import 'package:flutter/material.dart';

class AppColors {
  static AppColors? _instance;

  AppColors._();

  static AppColors get i => _instance ??= AppColors._();

  PrimaryColors get primary => PrimaryColors.i;
  SecondaryColors get secondary => SecondaryColors.i;
  SuccessColors get success => SuccessColors.i;
  WarningColors get warning => WarningColors.i;
  DangerColors get danger => DangerColors.i;
  GrayScaleColors get grayScale => GrayScaleColors.i;
}

class PrimaryColors {
  static PrimaryColors? _instance;

  PrimaryColors._();

  static PrimaryColors get i => _instance ??= PrimaryColors._();

  Color get bg => const Color(0xFFEBECFE);
  Color get bgStrong => const Color(0xFFBFBEFC);
  Color get df => const Color(0xFF610BEF);
  Color get dfWeak => const Color(0xFFA996FF);
  Color get dfStrong => const Color(0xFF4700AB);
}

class SecondaryColors {
  static SecondaryColors? _instance;

  SecondaryColors._();

  static SecondaryColors get i => _instance ??= SecondaryColors._();

  Color get bg => const Color(0xFFE3FEFF);
  Color get bgStrong => const Color(0xFF8DE9FF);
  Color get df => const Color(0xFF005BD4);
  Color get dfWeak => const Color(0xFF50C7FC);
  Color get dfStrong => const Color(0xFF0041AC);
}

class SuccessColors {
  static SuccessColors? _instance;

  SuccessColors._();

  static SuccessColors get i => _instance ??= SuccessColors._();

  Color get bg => const Color(0xFFEAF9DE);
  Color get bgStrong => const Color(0xFFCBFFAE);
  Color get df => const Color(0xFF008A00);
  Color get dfWeak => const Color(0xFFA6F787);
  Color get dfStrong => const Color(0xFF067306);
}

class WarningColors {
  static WarningColors? _instance;

  WarningColors._();

  static WarningColors get i => _instance ??= WarningColors._();

  Color get bg => const Color(0xFFFFF8E9);
  Color get bgStrong => const Color(0xFFFFE6B0);
  Color get df => const Color(0xFFEAAC30);
  Color get dfWeak => const Color(0xFFFFDF9A);
  Color get dfStrong => const Color(0xFF946300);
}

class DangerColors {
  static DangerColors? _instance;

  DangerColors._();

  static DangerColors get i => _instance ??= DangerColors._();

  Color get bg => const Color(0xFFFFECFC);
  Color get bgStrong => const Color(0xFFFFABE8);
  Color get df => const Color(0xFFCA024F);
  Color get dfWeak => const Color(0xFFFF75CA);
  Color get dfStrong => const Color(0xFF9E0038);
}

class GrayScaleColors {
  static GrayScaleColors? _instance;

  GrayScaleColors._();

  static GrayScaleColors get i => _instance ??= GrayScaleColors._();

  Color get transparent90 => const Color.fromRGBO(255, 255, 255, 0.9);
  Color get bg => const Color(0xFFFCFCFC);
  Color get bgWeak => const Color(0xFFF7F7FC);
  Color get input => const Color(0xFFEFF0F6);
  Color get line => const Color(0xFFD9DBE9);
  Color get placeholder => const Color(0xFFA0A3BD);
  Color get label => const Color(0xFF6E7191);
  Color get body => const Color(0xFF4E4B66);
  Color get headerWeak => const Color(0xFF262338);
  Color get header => const Color(0xFF14142B);
  Color get titleActive => const Color(0xFFFF13E7);
}

extension AppColorsExtension on BuildContext {
  AppColors get colors => AppColors.i;
}
