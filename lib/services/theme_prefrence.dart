import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../consts/consts.dart';

class ThemePrefrences {
  setTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(Consts.THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return prefs.getBool(Consts.THEME_STATUS) ?? isDarkMode;
  }
}
