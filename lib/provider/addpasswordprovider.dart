import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/addpasswordmodel.dart';
import '../services/databaseservice.dart';

class AddPasswordProvider with ChangeNotifier {
  // String _username = '';
  // String get username => _username;

  // set username(String username) {
  //   _username = username;
  //   notifyListeners();
  // }

  List<AddPasswordModel> _userPasswords = [];

  List<AddPasswordModel> get userPasswords => _userPasswords;

  Future<void> get fatchdata async {
    final DatabaseService _databaseService = DatabaseService();
    try {
      final data = await _databaseService.passwords();
      _userPasswords.clear();
      data.map((e) {
        _userPasswords.add(e);
        log(e.toMap().toString());
      }).toList();
      // log(data.first.title.toString());
      // log(userPasswords.s.title);
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }
}
