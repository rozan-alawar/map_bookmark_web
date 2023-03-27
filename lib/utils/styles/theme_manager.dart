// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

class AppTheme {
  static final lighTheme = ThemeData(
    scaffoldBackgroundColor: ColorManager.bg,
    fontFamily: FontConstants.segoeUI,
    backgroundColor: ColorManager.bg,
    colorScheme: ColorScheme.fromSwatch(backgroundColor: ColorManager.bg),
/*_________________________________________________________________________________________________________
  ____________________________________________     APP BAR THEME      _____________________________________
  _________________________________________________________________________________________________________*/
    appBarTheme: AppBarTheme(
      toolbarHeight: 80,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: getSemiBoldStyle(),
      backgroundColor: ColorManager.bg,
      iconTheme: const IconThemeData(
        color: ColorManager.black,
      ),
    ),

/*_________________________________________________________________________________________________________
  ____________________________________________     INPUT DECORATION   _____________________________________
  _________________________________________________________________________________________________________*/
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.white,
      enabledBorder: textFieldBorder.copyWith(
        borderSide: const BorderSide(color: ColorManager.grey),
      ),
      border: textFieldBorder.copyWith(
        borderSide: const BorderSide(color: ColorManager.red),
      ),
      focusedBorder: textFieldBorder,
      hintStyle: const TextStyle(
        color: ColorManager.grey,
      ),
    ),
/*_________________________________________________________________________________________________________
  ____________________________________________    ELEVATED BUTTON     _____________________________________
  _________________________________________________________________________________________________________*/
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
          backgroundColor: ColorManager.black,
          textStyle: getRegularStyle(
            color: ColorManager.white,
            fontSize: FontSize.s17,
          ),
          fixedSize: const Size(140, 44)),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: ColorManager.white.withOpacity(0.8),
    ),

/*_________________________________________________________________________________________________________
  ____________________________________________       TEXT THEME       _____________________________________
  _________________________________________________________________________________________________________*/
    textTheme: TextTheme(
        displayLarge: getBoldStyle(),
        displaySmall: getSemiBoldStyle(
          fontSize: FontSize.s18,
          color: ColorManager.black,
        ),
        titleLarge: getRegularStyle(
          fontSize: FontSize.s16,
        )),

/*_________________________________________________________________________________________________________
  ____________________________________________     APP BAR THEME      _____________________________________
  _________________________________________________________________________________________________________*/

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      // backgroundColor: ColorManager.teal,
      foregroundColor: ColorManager.white,
    ),
    //--------------------------------- bottom sheet theme ----------------------------------
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: ColorManager.white),

    //--------------------------------- card theme ----------------------------------

    cardTheme: const CardTheme(
      elevation: 5,
    ),
    //--------------------------------- dialog theme ----------------------------------

    dialogTheme: DialogTheme(
      backgroundColor: ColorManager.white,
      titleTextStyle: getSemiBoldStyle(
        color: ColorManager.black,
      ),
    ),
    //--------------------------------- checkbox theme ----------------------------------
    checkboxTheme: const CheckboxThemeData(
        // fillColor: MaterialStateProperty.all(ColorManager.teal),
        ),
    //--------------------------------- drawer theme ----------------------------------
    drawerTheme: DrawerThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      width: 200,
      backgroundColor: ColorManager.white,
    ),
  );
}

final textFieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(AppSize.s7),
  borderSide: const BorderSide(
    color: ColorManager.lightBlue,
  ),
);
