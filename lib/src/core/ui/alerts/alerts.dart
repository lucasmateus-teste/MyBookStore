import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/ui/alerts/alert_widget.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';

class Alerts {
  static void showSuccess(BuildContext context, String message) {
    SnackBar snackBar = AlertWidget(
      color: context.colors.success.bg,
      backgroundColor: AppColors.i.success.df,
      // imageIcon: CooIcons.cooCheck,
      message: message,
    ).build(context);

    show(context, snackBar);
  }

  static void showFailure(BuildContext context, String message) {
    SnackBar snackBar = AlertWidget(
      color: context.colors.danger.bg,
      backgroundColor: context.colors.danger.df,
      // icon: CooIcons.cooCrossCircle,
      message: message,
    ).build(context);

    show(context, snackBar);
  }

  static void show(BuildContext context, SnackBar snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
