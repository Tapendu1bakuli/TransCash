import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';
import 'package:trans_cash_solution/common/device_manager/colors.dart';

import '../common/device_manager/screen_constants.dart';
import '../common/device_manager/text_styles.dart';

class MyThemes {
  static final darkTheme =
      ThemeData(scaffoldBackgroundColor: AppColors.appAccentColor,
        indicatorColor: AppColors.appCommonBGColor,
        fontFamily: "Montserrat",
        textTheme: TextTheme(
          labelMedium: TextStyle(
              color: AppColors.white,
              fontSize: FontSize.s24,
              fontWeight: FontWeight.bold),
          displayLarge: TextStyle(
            color: AppColors.white,
            fontSize: FontSize.s21,
            fontWeight: FontWeight.w500,
          ),
          displayMedium: TextStyle(
          color: AppColors.white,
          fontSize: FontSize.s18,
          fontWeight: FontWeight.w400,
        ),
          headlineMedium: TextStyle(
            color: AppColors.white,
            fontSize: FontSize.s26,
            fontWeight: FontWeight.w700,
          ),
            bodySmall: TextStyle(
              color: AppColors.white,
              fontSize: FontSize.s16,
              fontWeight: FontWeight.w300,
            ),
          labelSmall: TextStyle(
            color: AppColors.white,
            fontSize: FontSize.s14,
            fontWeight: FontWeight.w400,
          ),
          displaySmall: TextStyle(
            color: AppColors.white,
            fontSize: FontSize.s14,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(
              color: AppColors.white,
              fontSize: FontSize.s16,
              fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(
          color: AppColors.white,
          fontSize: FontSize.s13,
        )
        ),
      );
  // displayLarge, displayMedium, displaySmall
  // headlineLarge, headlineMedium, headlineSmall
  // titleLarge, titleMedium, titleSmall
  // bodyLarge, bodyMedium, bodySmall
  // labelLarge, labelMedium, labelSmall
  static final lightTheme = ThemeData(
    fontFamily: "Montserrat",
    scaffoldBackgroundColor: AppColors.appCommonBGColor,
    indicatorColor: AppColors.appSecondaryDarkColor,
    textTheme: TextTheme(
      labelMedium: TextStyle(
          color: AppColors.baseBlack,
          fontSize: FontSize.s24,
          fontWeight: FontWeight.bold),
        displayLarge: TextStyle(
          color: AppColors.appAccentColor,
          fontSize: FontSize.s21,
          fontWeight: FontWeight.w500,
        ),
      displayMedium: TextStyle(
        color: AppColors.baseBlack,
        fontSize: FontSize.s18,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        color: AppColors.baseBlack,
        fontSize: FontSize.s26,
        fontWeight: FontWeight.w700,
      ),
      bodySmall: TextStyle(
        color: AppColors.baseBlack,
        fontSize: FontSize.s16,
        fontWeight: FontWeight.w300,
      ),
      labelSmall: TextStyle(
        color: AppColors.titleBlack,
        fontSize: FontSize.s14,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: TextStyle(
        color: AppColors.baseBlack,
        fontSize: FontSize.s14,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
          color: AppColors.baseBlack,
          fontSize: FontSize.s16,
          fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(
      color: AppColors.activityDetailsShareTextColor,
      fontSize: FontSize.s13,
    )
    ),
  );
}
