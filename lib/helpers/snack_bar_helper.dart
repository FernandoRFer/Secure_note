import 'package:flutter/material.dart';

class SnackBarHelper {
  static showSnackBar(BuildContext context, String message,
      {Color? color, Color? textColor}) {
    return snackBar(
        context,
        Text(
          message,
          style: const TextStyle(fontSize: 15),
        ),
        color: color,
        textColor: textColor);
  }

  static snackBar(BuildContext context, Widget child,
      {Color? color, Color? textColor}) {
    final SnackBar snackBarHomeView = SnackBar(
      backgroundColor: color,
      content: child,
      duration: const Duration(seconds: 1),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBarHomeView);
  }
}
