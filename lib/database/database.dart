import 'dart:io';

import 'package:flutter_todo_app/models/note_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_todo_app/models/note_model.dart';

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
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'todo_list.db';

    final todoListDB = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

    return todoListDB;
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDate TEXT, $colPriovity TEXT, $colStatus INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database? db = await this.db;

    final List<Map<String, dynamic>> result = await db!.query(noteTable);

    return result;
  }

  Future<List<Note>> getNoteList() async {
    final List<Map<String, dynamic>> noteMapLise = await getNoteMapList();

    final List<Note> noteList = [];

    noteMapLise.forEach((noteMap) {
      noteList.add(Note.fromMap(noteMap));
    });

    noteList.sort((noteA, noteB) => noteA.date!.compareTo(noteB.date!));

    return noteList;
  }

  Future<int> insertNote(Note note) async {
    Database? db = await this.db;

    final int result = await db!.update(
      noteTable,
      note.toMap(),
      where: '$colId = ?',
      whereArgs: [note.id],
    );

    return result;
  }

  Future<int> updateNote(Note note) async {
    Database? db = await this.db;

    final int result = await db!.update(
        noteTable,
        note.toMap(),
        where: '$colId = ?',
        whereArgs: [note.id]
    );

    return result;
  }


  Future<int> deleteNote(int id) async {
    Database? db = await this.db;

    final int result = await db!.delete(
        noteTable,
        where: '$colId = ?',
        whereArgs: [id]
    );

    return result;
  }
}
