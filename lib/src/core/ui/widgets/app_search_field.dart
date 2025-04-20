import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';

class AppSearchField extends StatefulWidget {
  const AppSearchField({super.key, required this.hintText, this.onChanged});

  final String hintText;
  final Function(String)? onChanged;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      onChanged: widget.onChanged,
      hintText: widget.hintText,
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      backgroundColor: WidgetStatePropertyAll(context.colors.grayScale.input),
      elevation: WidgetStatePropertyAll(0),
      trailing: [const Icon(Icons.search)],
    );
  }
}
