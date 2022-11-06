import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import '../consts/consts.dart';

class ThemePrefrences {
  setTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(Consts.THEME_STATUS, value);
    log('theme set');
  }

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    log('theme get');
    return prefs.getBool(Consts.THEME_STATUS) ?? false;
  }
}
