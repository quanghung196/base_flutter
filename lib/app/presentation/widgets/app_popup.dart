import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class AppPopup {
  static Future<void> showCustomPopup(
    BuildContext context, {
    required Widget child,
    bool isDismissOutSide = true,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: isDismissOutSide,
      barrierColor: ColorConstants.white.withOpacity(0.6),
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        return AlertDialog(
          // elevation: 10.0,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 26.0, vertical: 32.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8.0,
            ),
          ),
          backgroundColor: Colors.white,
          content: SizedBox(
            width: width - 40,
            child: SingleChildScrollView(child: child),
          ),
        );
      },
    );
  }

  static Future<void> showAlertDialog({
    required BuildContext context,
    String? title,
    required String message,
    String? positiveButton,
    String? negativeButton,
    bool isPositiveRed = true,
    required Function() onPositiveButtonClicked,
  }) async {
    if (Platform.isIOS) {
      showCupertinoDialog<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(message),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: Text(negativeButton ?? UIText.cancel.tr()),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text(
                positiveButton ?? UIText.yes.tr(),
                style: isPositiveRed
                    ? null
                    : const TextStyle(
                        color: CupertinoColors.systemBlue,
                      ),
              ),
              isDestructiveAction: true,
              onPressed: () {
                onPositiveButtonClicked();
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(negativeButton ?? UIText.cancel.tr()),
            ),
            TextButton(
              onPressed: () {
                onPositiveButtonClicked();
                Navigator.pop(context);
              },
              child: Text(
                positiveButton ?? positiveButton ?? UIText.yes.tr(),
                style: isPositiveRed
                    ? const TextStyle(
                        color: ColorConstants.red,
                      )
                    : null,
              ),
            ),
          ],
        ),
      );
    }
  }
}
