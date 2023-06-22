import 'package:favicon/favicon.dart';
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

  Future<String> getFavcicoUrl({required String url}) async {
    var iconUrl = await FaviconFinder.getBest(url);
    return iconUrl!.url;
  }

  Future<void> get fatchdata async {
    _isloading = true;
    final DatabaseService databaseService = DatabaseService();
    _userPasswords = [];

    try {
      final data = await databaseService.passwords();

      if (data.isEmpty) {
        _isloading = false;
      }
      data.map((e) async {
        final newPass = AddPasswordModel(
          title: e.title,
          url: e.url,
          username: e.username,
          password: e.password,
          notes: e.notes,
          id: e.id,
          addeddate: e.addeddate,
        );
        _userPasswords.add(newPass);

        _isloading = false;
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
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
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  Future<void> deletePassword() async {
    try {
      await _databaseService.deletePassword(_id);
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }
}
