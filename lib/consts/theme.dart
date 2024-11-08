import 'package:flutter/material.dart';

const primaryColor = Colors.deepOrange;

const secondaryColor = Colors.deepOrangeAccent;

ThemeData lightTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: primaryColor,
  // canvasColor: Colors.white,
  // fontFamily: 'Roboto',
  indicatorColor: primaryColor,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: primaryColor,
    selectionColor: primaryColor.shade200,
    selectionHandleColor: primaryColor,
  ),
  appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: primaryColor),
      actionsIconTheme: IconThemeData(color: primaryColor)),

  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.white,
  ),

  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Colors.black87,
      fontSize: 24,
    ),
    titleMedium: TextStyle(
      color: Colors.black87,
      fontSize: 18,
    ),
    titleSmall: TextStyle(
      color: Colors.black87,
      fontSize: 16,
    ),
  ),
  listTileTheme: ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4), // Adjust the radius
    ),
    tileColor: primaryColor,
    iconColor: Colors.white,
    textColor: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    suffixIconColor: primaryColor,
    floatingLabelStyle: const TextStyle(
      color: primaryColor,
    ),
    focusColor: primaryColor,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    border: const OutlineInputBorder(
      // borderRadius: BorderRadius.all(
      //   Radius.circular(20),
      // ),
      borderSide: BorderSide(
        width: 2.0,
        color: primaryColor,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      // borderRadius: BorderRadius.all(
      //   Radius.circular(20),
      // ),
      borderSide: BorderSide(
        width: 2.0,
        color: primaryColor,
      ),
    ),
    errorBorder: const OutlineInputBorder(
      // borderRadius: BorderRadius.all(
      //   Radius.circular(20),
      // ),
      borderSide: BorderSide(
        width: 2.0,
        color: Colors.red,
      ),
    ),
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: primaryColor,
    inactiveTrackColor: primaryColor.withOpacity(0.5),
    thumbColor: primaryColor,
    overlayColor: primaryColor.withOpacity(0.5),
  ),
  switchTheme: SwitchThemeData(
    thumbColor:
        WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Colors.white;
    }),
    trackColor:
        WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return primaryColor;
      }
      return null;
    }),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      // padding: WidgetStatePropertyAll(
      //   const EdgeInsets.symmetric(
      //     vertical: 20,
      //     horizontal: 40,
      //   ),
      // ),

      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      foregroundColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return Colors.white;
      }),
      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey[400]; // Disabled background color
          }
          if (states.contains(WidgetState.selected)) {
            return primaryColor; // Selected background color
          }
          return primaryColor; // Default enabled background color
        },
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      // textStyle: WidgetStateProperty.all(
      //   TextStyle(
      //     color: primaryColor,
      //     decorationColor: Colors.red,
      //     // Avoid using `backgroundColor` in `TextStyle`, it might not work as expected
      //   ),
      // ),
      foregroundColor:
          WidgetStateProperty.all(primaryColor), // This sets the text color
      overlayColor: WidgetStateProperty.all(primaryColor.shade100),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: secondaryColor,
  // canvasColor: Colors.white,
  // fontFamily: 'Roboto',
  indicatorColor: secondaryColor,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: secondaryColor,
    selectionColor: secondaryColor.shade200,
    selectionHandleColor: secondaryColor,
  ),
  appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: secondaryColor),
      actionsIconTheme: IconThemeData(color: secondaryColor)),

  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.white,
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
      fontSize: 12,
    ),
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 24,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
    titleSmall: TextStyle(
      color: Colors.white,
      fontSize: 16,
    ),
  ),
  listTileTheme: ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4), // Adjust the radius
    ),
    tileColor: secondaryColor,
    iconColor: Colors.white,
    textColor: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    suffixIconColor: secondaryColor,
    floatingLabelStyle: const TextStyle(
      color: secondaryColor,
    ),
    focusColor: secondaryColor,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    border: const OutlineInputBorder(
      // borderRadius: BorderRadius.all(
      //   Radius.circular(20),
      // ),
      borderSide: BorderSide(
        width: 2.0,
        color: secondaryColor,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      // borderRadius: BorderRadius.all(
      //   Radius.circular(20),
      // ),
      borderSide: BorderSide(
        width: 2.0,
        color: secondaryColor,
      ),
    ),
    errorBorder: const OutlineInputBorder(
      // borderRadius: BorderRadius.all(
      //   Radius.circular(20),
      // ),
      borderSide: BorderSide(
        width: 2.0,
        color: Colors.red,
      ),
    ),
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: secondaryColor,
    inactiveTrackColor: secondaryColor.withOpacity(0.5),
    thumbColor: secondaryColor,
    overlayColor: secondaryColor.withOpacity(0.5),
  ),
  switchTheme: SwitchThemeData(
    thumbColor:
        WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Colors.white;
    }),
    trackColor:
        WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return secondaryColor;
      }
      return null;
    }),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: secondaryColor,
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      // padding: WidgetStatePropertyAll(
      //   const EdgeInsets.symmetric(
      //     vertical: 20,
      //     horizontal: 40,
      //   ),
      // ),

      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      foregroundColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return Colors.white;
      }),
      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey[400]; // Disabled background color
          }
          if (states.contains(WidgetState.selected)) {
            return secondaryColor; // Selected background color
          }
          return secondaryColor; // Default enabled background color
        },
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      // textStyle: WidgetStateProperty.all(
      //   TextStyle(
      //     color: primaryColor,
      //     decorationColor: Colors.red,
      //     // Avoid using `backgroundColor` in `TextStyle`, it might not work as expected
      //   ),
      // ),
      foregroundColor:
          WidgetStateProperty.all(secondaryColor), // This sets the text color
      overlayColor: WidgetStateProperty.all(secondaryColor.shade100),
    ),
  ),
);
