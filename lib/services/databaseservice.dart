import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/addpasswordmodel.dart';

class DatabaseService with ChangeNotifier {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'passwords.db');
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE passwords(id TEXT PRIMARY KEY, title TEXT, url TEXT,username TEXT,password TEXT,notes TEXT,addeddate TEXT)',
    );
  }

  Future<void> addPassword({required AddPasswordModel password}) async {
    final db = await _databaseService.database;

    await db.insert(
      'passwords',
      password.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
    log('inputted data ${password.toMap().toString()}');
  }

  Future<List<AddPasswordModel>> passwords() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('passwords');
    return List.generate(maps.length, (index) {
      notifyListeners();
      return AddPasswordModel.fromMap(maps[index]);
    });
  }

  Future<AddPasswordModel> selectedPasword(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('passwords', where: 'id = ?', whereArgs: [id]);
    notifyListeners();
    return AddPasswordModel.fromMap(maps[0]);
  }

  Future<void> deletePassword(String id) async {
    final db = await _databaseService.database;
    await db.delete(
      'passwords',
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  Future<void> updatePassword({required AddPasswordModel password}) async {
    final db = await _databaseService.database;

    await db.update(
      'passwords',
      password.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: 'id = ?',
      whereArgs: [password.id],
    );

    log('${password.id} updated');
    // log(db.toString());
    notifyListeners();
  }

  Future<void> clearHistory() async {
    final db = await _databaseService.database;

    await db.delete(
      'passwords',
    );
  }
}
