import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: context.colors.primary.df,
        strokeWidth: 3,
      ),
    );
  }
}
