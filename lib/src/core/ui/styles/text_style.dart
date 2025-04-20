import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';

class TextStyles {
  static TextStyles? _instance;

  TextStyles._();

  static TextStyles get i => _instance ??= TextStyles._();

  final TextStyle style = TextStyle(
    color: AppColors.i.grayScale.header,
    fontFamily: 'Poppins',
  );

  final DisplayStyles display = DisplayStyles();
  final TextStylesGroup text = TextStylesGroup();
  final LinkStyles link = LinkStyles();
}

class DisplayStyles {
  TextStyle get huge =>
      TextStyles.i.style.copyWith(fontWeight: FontWeight.w400, fontSize: 32);
  TextStyle get large =>
      TextStyles.i.style.copyWith(fontWeight: FontWeight.w400, fontSize: 28);
  TextStyle get medium =>
      TextStyles.i.style.copyWith(fontWeight: FontWeight.w400, fontSize: 24);
  TextStyle get small =>
      TextStyles.i.style.copyWith(fontWeight: FontWeight.w400, fontSize: 20);

  TextStyle get hugeBold =>
      TextStyles.i.style.copyWith(fontWeight: FontWeight.w700, fontSize: 32);
  TextStyle get largeBold =>
      TextStyles.i.style.copyWith(fontWeight: FontWeight.w700, fontSize: 28);
  TextStyle get mediumBold =>
      TextStyles.i.style.copyWith(fontWeight: FontWeight.w700, fontSize: 24);
  TextStyle get smallBold =>
      TextStyles.i.style.copyWith(fontWeight: FontWeight.w700, fontSize: 20);
}

class TextStylesGroup {
  TextStyle get large =>
      TextStyles.i.style.copyWith(fontWeight: FontWeight.w400, fontSize: 20);
  TextStyle get medium =>
      TextStyles.i.style.copyWith(fontWeight: FontWeight.w400, fontSize: 17);
  TextStyle get small =>
      TextStyles.i.style.copyWith(fontWeight: FontWeight.w400, fontSize: 14);
  TextStyle get x =>
      TextStyles.i.style.copyWith(fontWeight: FontWeight.w400, fontSize: 13);
}

class LinkStyles {
  TextStyle get large =>
      TextStyles.i.style.copyWith(fontWeight: FontWeight.w600, fontSize: 20);
  TextStyle get medium =>
      TextStyles.i.style.copyWith(fontWeight: FontWeight.w600, fontSize: 17);
  TextStyle get small =>
      TextStyles.i.style.copyWith(fontWeight: FontWeight.w600, fontSize: 14);
  TextStyle get x =>
      TextStyles.i.style.copyWith(fontWeight: FontWeight.w600, fontSize: 13);
}

extension TextStylesExtension on BuildContext {
  TextStyles get textStyles => TextStyles.i;
}
