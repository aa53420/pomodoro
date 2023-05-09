import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum NoticeLevel { info, alert, error }

class Notice {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    NoticeLevel level = NoticeLevel.info,
  }) {
    final Color backgroundColor;
    final Color textColor;

    switch (level) {
      case NoticeLevel.info:
        backgroundColor = Theme.of(context).colorScheme.primary;
        textColor = Colors.white;
        break;
      case NoticeLevel.alert:
        backgroundColor = Theme.of(context).colorScheme.primary;
        textColor = Colors.white;
        break;
      case NoticeLevel.error:
        backgroundColor = Theme.of(context).colorScheme.primary;
        textColor = Colors.white;
        break;
    }

    final customTextTheme =
        Theme.of(context).textTheme.displaySmall!.copyWith(color: textColor);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: customTextTheme,
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
