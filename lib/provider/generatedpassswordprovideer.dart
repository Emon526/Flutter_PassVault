import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_password_generator/random_password_generator.dart';

class GeneratedPasswordProvider with ChangeNotifier {
  bool _uppercaseatoz = true;
  bool get uppercaseatoz => _uppercaseatoz;
  set uppercaseatoz(bool value) {
    _uppercaseatoz = value;
    if (_lowercaseatoz == false) _lowercaseatoz = true;
    notifyListeners();
  }

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

  bool _specialchar = false;
  bool get specialchar => _specialchar;
  set specialchar(bool value) {
    _specialchar = value;
    notifyListeners();
  }

  double _length = 10;
  double get length => _length;
  set length(double value) {
    _length = value;
    notifyListeners();
  }

  double _minimumnumbers = 3;
  double get minimumnumbers => _minimumnumbers;

  void minimumnumberincrement() {
    if (_minimumnumbers < 5) _minimumnumbers += 1;
    notifyListeners();
  }

  void minimumnumberdecrement() {
    if (_minimumnumbers > 0) _minimumnumbers -= 1;

    notifyListeners();
  }

  double _minimumspecial = 0;
  double get minimumspecial => _minimumspecial;

  void minimumnspecialincrement() {
    if (_minimumspecial < 5) {
      _minimumspecial += 1;
      notifyListeners();
    }
  }

  void minimumspecialdecrement() {
    if (_minimumspecial > 0) {
      _minimumspecial -= 1;

      notifyListeners();
    }
  }

  String _generatedpassword = '';
  String get generatedpassword => _generatedpassword;
  void get generatePassword {
    // final password = RandomPasswordGenerator();
    // _generatedpassword = password.randomPassword(
    //   letters: _lowercaseatoz,
    //   numbers: _number,
    //   passwordLength: _length,
    //   specialChar: _specialchar,
    //   uppercase: _uppercaseatoz,
    // );

    _generatedpassword = generaterandomPassword();

    double passwordstrength = checkPasswordStrength(
      password: _generatedpassword,
    );
    print(_generatedpassword);
    print(passwordstrength.toString());
    // notifyListeners();
  }

  String generaterandomPassword() {
    final length = _length.toInt();
    const letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    const letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const number = '0123456789';
    const special = '@#%^*>\$@?/[]=+';

    String chars = "";
    // if (letter) chars += '$letterLowerCase$letterUpperCase';
    if (_uppercaseatoz) chars += letterUpperCase;
    if (_lowercaseatoz) chars += letterLowerCase;
    if (_number) chars += number;
    if (_specialchar) chars += special;

    return List.generate(
      length,
      (index) {
        final indexRandom = Random.secure().nextInt(chars.length);
        return chars[indexRandom];
      },
    ).join('');
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
