import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/addpasswordmodel.dart';
import '../services/databaseservice.dart';

class AddPasswordProvider with ChangeNotifier {
  String _id = '';
  String get id => _id;

  bool _isloading = false;
  bool get isloading => _isloading;

  String _username = '';
  String get username => _username;

  String _title = '';
  String get title => _title;

  String? _url = '';
  String? get url => _url;

  String _password = '';
  String get password => _password;

  DateTime _addeddate = DateTime.now();
  DateTime get addeddate => _addeddate;

  String? _notes = '';
  String? get notes => _notes;

  final DatabaseService _databaseService = DatabaseService();
  List<AddPasswordModel> _userPasswords = [];

  List<AddPasswordModel> get userPasswords => _userPasswords;

  set userPasswords(List<AddPasswordModel> userpasswords) {
    _userPasswords = userpasswords;
    // log('nulled');
    notifyListeners();
  }

  String _controllertext = '';
  String get controllertext => _controllertext;

  set controllertext(String controllertext) {
    _searchresult = [];
    _controllertext = controllertext;

    for (var passwords in _userPasswords) {
      if (passwords.title.contains(controllertext)) {
        _searchresult.add(passwords);
      }
    }
    notifyListeners();
  }

  List<AddPasswordModel> _searchresult = [];

  List<AddPasswordModel> get searchresult => _searchresult;

  Future<void> get fatchdata async {
    _isloading = true;
    final DatabaseService _databaseService = DatabaseService();

    try {
      final data = await _databaseService.passwords();

      // _userPasswords = [];
      if (data.isEmpty) {
        _isloading = false;
      }
      data.map((e) async {
        // var iconUrl = await FaviconFinder.getBest(e.url!);

        final newPass = AddPasswordModel(
          title: e.title,
          // url: iconUrl!.url,
          url: e.url,
          username: e.username,
          password: e.password,
          notes: e.notes,
          id: e.id,
          addeddate: e.addeddate,
        );
        _userPasswords.add(newPass);

        // log('add passwordproider');
        // log(e.toMap().toString());

        // var now = DateTime.now();
        // var addeddate = DateTime.parse("2022-10-27 10:09:00");
        // log(now.toString());
        // log(addeddate.toString());
        // log(now.difference(addeddate).inDays.toString());

        _isloading = false;
        notifyListeners();
      }).toList();
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
    log(_isloading.toString());
  }

  Future<void> getPasswordData({
    required int id,
  }) async {
    try {
      final data = await _databaseService.selectedPasword(id);
      _title = data.title;
      _url = data.url;
      _username = data.username;
      _password = data.password;
      _notes = data.notes;
      _id = id.toString();

      _addeddate = data.addeddate;

      // log(data.first.title.toString());
      log(data.id);
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> deletePassword() async {
    try {
      await _databaseService.deletePassword(_id);

      log('$_id deleted');
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }
}
