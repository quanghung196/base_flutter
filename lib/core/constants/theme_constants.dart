import 'package:flutter/material.dart';

import 'constants.dart';

class ThemeConstants {
  ThemeConstants._();

  static ThemeData get(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorConstants.white,
        foregroundColor: ColorConstants.primary,
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: ColorConstants.primary,
        unselectedLabelColor: ColorConstants.black,
        indicator: UnderlineTabIndicator(
          insets: EdgeInsets.symmetric(horizontal: 16),
          borderSide: BorderSide(
            color: ColorConstants.primary,
            width: 2,
          ),
        ),
        labelPadding: EdgeInsets.all(8),
      ),
      primarySwatch: ColorConstants.primaryColorSwatch,
      primaryColor: ColorConstants.primary,
      hintColor: ColorConstants.grey,
      inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          hintStyle: StyleConstants.mediumText.copyWith(
            color: ColorConstants.grey,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: ColorConstants.primary, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: ColorConstants.borderGrey, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: ColorConstants.borderGrey, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorConstants.red, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorConstants.red, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          errorStyle: const TextStyle(color: ColorConstants.red, height: 1)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 0,
          ),
          onPrimary: ColorConstants.white,
          primary: ColorConstants.primary,
          splashFactory: InkRipple.splashFactory,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            side: BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(ColorConstants.white),
        side: const BorderSide(
          color: ColorConstants.primary,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        fillColor: MaterialStateProperty.all(ColorConstants.primary),
      ),
    );
  }
}
