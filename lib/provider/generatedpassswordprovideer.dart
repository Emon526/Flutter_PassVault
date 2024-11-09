import 'dart:math';

import 'package:flutter/material.dart';

class GeneratedPasswordProvider with ChangeNotifier {
  bool _uppercaseatoz = true;
  bool get uppercaseatoz => _uppercaseatoz;
  set uppercaseatoz(bool value) {
    _uppercaseatoz = value;
    if (_lowercaseatoz == false) _lowercaseatoz = true;
    notifyListeners();
  }

  double _passwordstrength = 0;
  double get passwordstrength => _passwordstrength;

  bool _lowercaseatoz = true;
  bool get lowercaseatoz => _lowercaseatoz;
  set lowercaseatoz(bool value) {
    _lowercaseatoz = value;
    if (_uppercaseatoz == false) _uppercaseatoz = true;
    notifyListeners();
  }

  bool _number = true;
  bool get number => _number;
  set number(bool value) {
    _number = value;
    notifyListeners();
  }

  bool _specialchar = true;
  bool get specialchar => _specialchar;
  set specialchar(bool value) {
    _specialchar = value;
    notifyListeners();
  }

  double _length = 15;
  double get length => _length;
  set length(double value) {
    _length = value;
    notifyListeners();
  }

  double _minimumnumbers = 3;
  double get minimumnumbers => _minimumnumbers;

  void minimumnumberincrement() {
    if (_minimumnumbers < 5) {
      _minimumnumbers += 1;
      notifyListeners();
    }
  }

  void minimumnumberdecrement() {
    if (_minimumnumbers > 1) {
      _minimumnumbers -= 1;

      notifyListeners();
    }
  }

  double _minimumspecial = 1;
  double get minimumspecial => _minimumspecial;

  void minimumnspecialincrement() {
    if (_minimumspecial < 5) {
      _minimumspecial += 1;
      notifyListeners();
    }
  }

  void minimumspecialdecrement() {
    if (_minimumspecial > 1) {
      _minimumspecial -= 1;

      notifyListeners();
    }
  }

  String _generatedpassword = '';
  String get generatedpassword => _generatedpassword;

  void get generatePassword {
    try {
      var randompass = generaterandomPassword(
        length: _length.toInt(),
        minimumSpecialCharacterCount: _minimumspecial.toInt(),
        minimumnumberCount: _minimumnumbers.toInt(),
        lowercase: _lowercaseatoz,
        uppercase: _uppercaseatoz,
        isspecial: _specialchar,
        number: _number,
      );
      _generatedpassword = randompass;

      _passwordstrength = checkPasswordStrength(
        password: _generatedpassword,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  String generaterandomPassword({
    required int length,
    required int minimumSpecialCharacterCount,
    required int minimumnumberCount,
    required bool lowercase,
    required bool uppercase,
    required bool number,
    required bool isspecial,
  }) {
    final random = Random.secure();

    const letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    const letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const numbers = '0123456789';
    const special = '@#%^*>\$?/[]=+';

    assert(
        length >= minimumSpecialCharacterCount || length >= minimumnumberCount);

    String allValidCharacters = '';

    if (uppercase) allValidCharacters += letterUpperCase;
    if (lowercase) allValidCharacters += letterLowerCase;

    var specials = [
      for (var i = 0; i < minimumSpecialCharacterCount; i += 1)
        special[random.nextInt(special.length)],
    ];
    var selectednumbers = [
      for (var i = 0; i < minimumnumberCount; i += 1)
        numbers[random.nextInt(numbers.length)],
    ];

    var specialcount = isspecial && number
        ? minimumSpecialCharacterCount + minimumnumberCount
        : isspecial
            ? minimumSpecialCharacterCount
            : number
                ? minimumnumberCount
                : 0;

    var rest = [
      for (var i = 0; i < length - specialcount; i += 1)
        allValidCharacters[random.nextInt(allValidCharacters.length)],
    ];
    var mainstring = isspecial && number
        ? specials + selectednumbers + rest
        : isspecial
            ? specials + rest
            : number
                ? selectednumbers + rest
                : rest;
    return (mainstring..shuffle(random)).join();
  }

  double checkPasswordStrength({required String password}) {
    /// if [password] is empty return 0.0
    if (password.isEmpty) return 0.0;

    double bonus;
    if (RegExp(r'^[a-z]*$').hasMatch(password)) {
      bonus = 1.0;
    } else if (RegExp(r'^[a-z0-9]*$').hasMatch(password)) {
      bonus = 1.2;
    } else if (RegExp(r'^[a-zA-Z]*$').hasMatch(password)) {
      bonus = 1.3;
    } else if (RegExp(r'^[a-z\-_!?]*$').hasMatch(password)) {
      bonus = 1.3;
    } else if (RegExp(r'^[a-zA-Z0-9]*$').hasMatch(password)) {
      bonus = 1.5;
    } else {
      bonus = 1.8;
    }

    /// return double value [0-1]
    logistic(double x) {
      return 1.0 / (1.0 + exp(-x));
    }

    /// return double value [0-1]
    curve(double x) {
      return logistic((x / 3.0) - 4.0);
    }

    /// return double value [0-1]
    return curve(password.length * bonus);
  }
}
