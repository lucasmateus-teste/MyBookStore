import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';

class AppDateInput extends StatelessWidget {
  const AppDateInput({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.onClear,
  });

  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1500),
          lastDate: DateTime.now(),
        );
        if (date != null) {
          controller.text = DateFormat('dd/MM/yyyy').format(date);
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 20,
            ),
            filled: true,
            fillColor: context.colors.grayScale.input,
            labelText: labelText,
            labelStyle: context.textStyles.text.small.copyWith(
              color: context.colors.grayScale.label,
            ),
            hintText: hintText,
            hintStyle: context.textStyles.text.small.copyWith(
              color: context.colors.grayScale.label,
            ),
            suffixIcon:
                onClear != null
                    ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: onClear,
                    )
                    : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
