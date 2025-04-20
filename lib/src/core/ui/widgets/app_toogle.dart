import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';

class AppToogle extends StatefulWidget {
  const AppToogle({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.child,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;
  final Widget? child;

  @override
  State<AppToogle> createState() => _AppToogleState();
}

class _AppToogleState extends State<AppToogle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: widget.value,
          onChanged: (value) {
            widget.onChanged(value);
          },

          thumbColor: WidgetStateColor.resolveWith(
            (states) => context.colors.grayScale.bg,
          ),
          trackColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return context.colors.primary.df;
            }
            return context.colors.grayScale.placeholder;
          }),
        ),
        if (widget.label != null)
          Text(widget.label!, style: context.textStyles.text.small),
        if (widget.child != null) widget.child!,
      ],
    );
  }
}
