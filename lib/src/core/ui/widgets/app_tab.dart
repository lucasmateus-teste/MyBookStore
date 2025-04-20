import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';

class AppTab extends StatefulWidget {
  const AppTab({
    super.key,
    required this.label,
    required this.isSelected,
    this.onPressed,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onPressed;

  @override
  State<AppTab> createState() => _AppTabState();
}

class _AppTabState extends State<AppTab> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color:
              widget.isSelected
                  ? context.colors.grayScale.line
                  : context.colors.grayScale.bg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: context.textStyles.link.small.copyWith(
                color:
                    widget.isSelected
                        ? context.colors.grayScale.header
                        : context.colors.grayScale.label,
              ),
            ),
            if (widget.isSelected)
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: context.colors.grayScale.header,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
