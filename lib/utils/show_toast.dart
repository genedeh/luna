import 'package:flutter/material.dart';
import 'package:luna/utils/animations.dart';
import 'package:luna/widgets/toast_widget.dart';

void showToast(
  BuildContext context, {
  required String title,
  required String description,
  required int type,
  required bool isDarkMode,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 4,
      key: Key('$title-$type'),
      behavior: SnackBarBehavior.floating,
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      showCloseIcon: true,
      closeIconColor: isDarkMode ? Colors.white : Colors.black,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      duration: const Duration(seconds: 3),
      content: RightSlideIn(
        child: ToastWidget(
          title: title,
          description: description,
          type: type,
          isDarkMode: isDarkMode,
        ),
      ),
    ),
  );
}
