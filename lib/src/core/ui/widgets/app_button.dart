import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';

class AppButton extends StatefulWidget {
  const AppButton({super.key, this.onPressed, this.child});

  final VoidCallback? onPressed;
  final Widget? child;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          widget.onPressed != null
              ? context.colors.primary.df
              : context.colors.grayScale.label,
        ),
        padding: WidgetStatePropertyAll(
          const EdgeInsets.symmetric(vertical: 19, horizontal: 32),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      child: widget.child,
    );
  }
}
