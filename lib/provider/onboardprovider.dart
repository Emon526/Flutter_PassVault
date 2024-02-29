import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingProvider with ChangeNotifier {
  OnBoardingProvider() {
    getOnboardInfo();
  }
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(value) {
    _currentIndex = value;
    notifyListeners();
  }

  bool _isBoardingCompleate = false;
  bool get isBoardingCompleate => _isBoardingCompleate;
  set isBoardingCompleate(bool value) {
    _isBoardingCompleate = value;
    storeOnboardInfo();
    notifyListeners();
  }

  void storeOnboardInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onBoard', _isBoardingCompleate);
    log(_isBoardingCompleate.toString(), name: 'setonBoard');
  }

  void getOnboardInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isBoardingCompleate = prefs.getBool('onBoard') ?? false;
    log(isBoardingCompleate.toString(), name: 'onBoard');
  }
}
