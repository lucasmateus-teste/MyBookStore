import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';
import 'package:my_book_store/src/core/ui/widgets/app_back_button.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key, this.title = '', this.withBackButton = true});

  final String title;
  final bool withBackButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Row(
        children: [
          if (withBackButton) AppBackButton(),
          const SizedBox(width: 16),
          if (title.isNotEmpty)
            Text(
              title,
              style: context.textStyles.display.mediumBold.copyWith(
                color: context.colors.grayScale.header,
              ),
            ),
        ],
      ),
    );
  }
}
