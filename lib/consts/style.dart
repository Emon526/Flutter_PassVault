import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.white,
      // primarySwatch: Colors.deepOrange,
      appBarTheme: AppBarTheme(
        // systemOverlayStyle: SystemUiOverlayStyle(
        //   statusBarBrightness:
        //       isDarkTheme ? Brightness.light : Brightness.dark,
        //   statusBarIconBrightness:
        //       isDarkTheme ? Brightness.light : Brightness.dark,
        //   statusBarColor: isDarkTheme ? Colors.red : Colors.red,
        // ),
        iconTheme: IconThemeData(
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
      ),
      iconTheme: IconThemeData(
        color: isDarkTheme ? Colors.white : Colors.black,
      ),
      // indicatorColor: Colors.orangeAccent,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: isDarkTheme ? Colors.deepOrangeAccent : Colors.deepOrangeAccent,
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.deepOrangeAccent,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: Colors.deepOrangeAccent,
        inactiveTrackColor: Colors.deepOrangeAccent.withOpacity(0.5),
        thumbColor: Colors.deepOrangeAccent,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.deepOrangeAccent;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.deepOrangeAccent;
          }
          return null;
        }),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.deepOrangeAccent, //<-- SEE HERE
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          color: Colors.deepOrangeAccent,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: Colors.deepOrangeAccent,
          ),
        ),
        focusColor: Colors.red,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: Colors.deepOrangeAccent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: Colors.deepOrangeAccent,
          ),
        ),
      ),
      primaryColor:
          isDarkTheme ? Colors.deepOrangeAccent : Colors.deepOrangeAccent,
      colorScheme: ThemeData().colorScheme.copyWith(
            secondary:
                isDarkTheme ? Colors.deepOrangeAccent : Colors.deepOrangeAccent,
            //     isDarkTheme ? const Color(0xff828282) : const Color(0xff777778),
            brightness: isDarkTheme ? Brightness.dark : Brightness.light,
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: isDarkTheme ? Colors.grey : Colors.grey,
          backgroundColor:
              isDarkTheme ? Colors.deepOrangeAccent : Colors.deepOrangeAccent,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.deepOrangeAccent,
        ),
      ),

      // buttonColor:
      //     isDarkTheme ? const Color(0xffD5D5D5) : const Color(0xffD5D5D5),
      // cardColor:
      //     isDarkTheme ? const Color(0xff141416) : const Color(0xffFFFFFF),
      // canvasColor:
      //     isDarkTheme ? const Color(0xff212121) : const Color(0xffE5E0E0),
      // buttonTheme: Theme.of(context).buttonTheme.copyWith(
      //       buttonColor: isDarkTheme ? Colors.green : Colors.blue,
      //       colorScheme: isDarkTheme
      //           ? const ColorScheme.light()
      //           : const ColorScheme.dark(),
      //     ),
    );
  }
}
