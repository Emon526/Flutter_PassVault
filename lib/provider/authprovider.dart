import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider() {
    getMasterPassword();
  }
  bool _isObsecured = true;
  bool get isObsecured => _isObsecured;
  set isObsecured(bool value) {
    _isObsecured = value;
    notifyListeners();
  }

  late String _masterpassword;
  String get masterpassword => _masterpassword;
  set masterpassword(String value) {
    _masterpassword = value;
    notifyListeners();
  }

  void savePassword({required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
  }

  Future<void> getMasterPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    masterpassword = prefs.getString('password') ?? '';
  }
}
