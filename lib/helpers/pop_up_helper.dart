import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../core/core.dart';

class PopUp {
  static void showSnackBar(
    BuildContext context, {
    String? msg,
  }) {
    if (msg == null) return;
    final snackBar = SnackBar(
      content: Text(
        msg,
        style: StyleConstants.mediumText.copyWith(
          color: ColorConstants.white,
        ),
      ),
      backgroundColor: ColorConstants.primary,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showFeatureUnderConstructionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(MessageText.underConstruction.tr()),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
