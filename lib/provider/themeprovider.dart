import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider(BuildContext context) {
    getSystemTheme(context);
    getTheme();
  }
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    saveTheme(themeMode: themeMode.name);
    notifyListeners();
  }

  saveTheme({required String themeMode}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', themeMode);
  }

  getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var theme = prefs.getString('themeMode') ?? 'system';
    _themeMode = ThemeMode.values.firstWhere(
        (element) => element.toString() == 'ThemeMode.$theme',
        orElse: () => ThemeMode.system);
    // notifyListeners();
  }

  getSystemTheme(BuildContext context) {
    _isDarkTheme =
        // WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
        WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;
    // notifyListeners();
  }
}
