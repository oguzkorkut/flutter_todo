import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();

  static Database? _db = null;
  DatabaseHelper._instance();

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDate = 'date';
  String colPriovity = 'priovity';
  String colStatus = 'status';


  Future<Database?> get db async {
    if(_db == null){

    }
    return _db;
  }

  Future<Database> _initDb() async {
      Directory dir = await getApplicationDocumentsDirectory();
      String path = dir.path + 'todo_list.db';
  }

  void _createDb(Database db, int version) {
    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDate TEXT, $colPriovity TEXT, $colStatus INTEGER)');
  }
}