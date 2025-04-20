import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';

class AppConfirmationDialog {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget? content,
    required VoidCallback onConfirm,
  }) async {
    return await showGeneralDialog<T>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox.shrink();
      },
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim1, curve: Curves.easeOut)),
          child: AlertDialog(
            backgroundColor: context.colors.grayScale.bg,
            actionsAlignment: MainAxisAlignment.spaceBetween,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            content: content,
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancelar',
                  style: context.textStyles.link.small.copyWith(
                    color: context.colors.primary.df,
                  ),
                ),
              ),
              FilledButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    context.colors.danger.df,
                  ),
                  padding: WidgetStatePropertyAll(
                    const EdgeInsets.symmetric(vertical: 19, horizontal: 32),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                onPressed: onConfirm,
                child: Text(
                  'Confirmar',
                  style: context.textStyles.link.small.copyWith(
                    color: context.colors.grayScale.bg,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
