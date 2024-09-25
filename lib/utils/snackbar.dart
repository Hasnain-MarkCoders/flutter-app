import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'color_utils.dart';

class CustomSnackBar {
  static showSuccessSnackBar(BuildContext context,
    { String? message, int milliseconds = 1500,
    SnackBarBehavior snackBarBehavior = SnackBarBehavior.floating}) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    backgroundColor: AppColor.appDarkColor,
    behavior: snackBarBehavior,
    action: SnackBarAction(
    textColor: Colors.white,
    label: 'DISMISS',
    onPressed: () => _dismissCurrentSnackBar(context)),
    duration: Duration(milliseconds: milliseconds),
    content: SelectableText(
    message ?? 'An error occured',
    style: const TextStyle(color: Colors.white),
    ),
    ),
    );
  }

  static void showErrorSnackBar(BuildContext context,
      { String? message,
        int milliseconds = 1500,
        SnackBarBehavior snackBarBehavior = SnackBarBehavior.floating}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColor.btn_red,
        behavior: snackBarBehavior,
        action: SnackBarAction(
            textColor: Colors.white,
            label: 'DISMISS',
            onPressed: () => _dismissCurrentSnackBar(context)),
        duration: Duration(milliseconds: milliseconds),
        content: SelectableText(
          message ?? 'An error occured',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  static void _dismissCurrentSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}