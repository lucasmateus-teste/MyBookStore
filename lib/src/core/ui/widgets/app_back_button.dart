import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: context.colors.primary.df,
        shape: const CircleBorder(),

        padding: const EdgeInsets.all(12),
      ),
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Icon(
        size: 16,
        Icons.arrow_back_ios_new_rounded,
        color: AppColors.i.grayScale.bg,
      ),
    );
  }
}
