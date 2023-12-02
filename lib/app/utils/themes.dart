import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'colors.dart';

final ThemeData lightTheme = ThemeData(
  drawerTheme: const DrawerThemeData(
      // backgroundColor: backgroundColor.withOpacity(0.90),
      ),
  brightness: Brightness.light,
  listTileTheme: const ListTileThemeData(),
  // primarySwatch: buttonColor,
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: const TextStyle(
      color: primaryTextColor,
      fontFamily: 'Plus Jakarta Sans',
    ),
    disabledBorder: (OutlineInputBorder(
      borderSide: BorderSide(color: borderColor),
      borderRadius: BorderRadius.circular(
        2.w,
      ),
    )),
    focusedBorder: (OutlineInputBorder(
      borderSide: BorderSide(color: borderColor),
      borderRadius: BorderRadius.circular(
        2.5.w,
      ),
    )),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(
        2.w,
      ),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(primaryColor),
    checkColor: MaterialStateProperty.all(Colors.white),
    side: BorderSide(
      color: borderColor,
      width: 0.3.w,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: fadedpurpleColor,
    elevation: 0,
    iconTheme: IconThemeData(color: backgroundColor),
    titleTextStyle: TextStyle(
      // fontFamily: Assets.jakartaFont,
      fontWeight: FontWeight.w600,
      fontSize: isTablet() ? 12.sp : 14.sp,
      color: backgroundColor,
    ),
  ),
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundColor,
  fontFamily: 'Plus JakartaSans',
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontFamily: 'Plus Jakarta Sans',
      fontSize: 20.sp,
      color: primaryTextColor,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: const TextStyle(
      color: primaryTextColor,
      fontFamily: 'Plus Jakarta Sans',
    ),
    displayLarge: const TextStyle(
      color: primaryTextColor,
      fontFamily: 'Plus Jakarta Sans',
    ),
    displayMedium: const TextStyle(
      color: primaryTextColor,
      fontFamily: 'Plus Jakarta Sans',
    ),
    displaySmall: const TextStyle(
      color: primaryTextColor,
      fontFamily: 'Plus Jakarta Sans',
    ),
    headlineMedium: const TextStyle(
      color: primaryTextColor,
      fontFamily: 'Plus Jakarta Sans',
    ),
    headlineSmall: const TextStyle(
      color: primaryTextColor,
      fontFamily: 'Plus Jakarta Sans',
    ),
    titleLarge: const TextStyle(
      color: primaryTextColor,
      fontFamily: 'Plus Jakarta Sans',
    ),
    titleMedium: const TextStyle(
      color: primaryTextColor,
      fontFamily: 'Plus Jakarta Sans',
    ),
    titleSmall: const TextStyle(
      color: primaryTextColor,
      fontFamily: 'Plus Jakarta Sans',
    ),
    bodySmall: const TextStyle(color: primaryTextColor),
    labelSmall: const TextStyle(color: primaryTextColor),
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(primary: primaryColor, secondary: Colors.white),
);
