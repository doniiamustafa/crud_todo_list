import 'package:crud_local_testing_app/features/todo_list/data/models/todo_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class DatabaseHandler {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'Todo.db');
    var db = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return db;
  }

  _createDatabase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE myTodoList(id INTEGER PRIMARY KEY AUTOINCREMENT , status TEXT NOT NULL, color TEXT NOT NULL, description TEXT NOT NULL, date TEXT NOT NULL, time TEXT NOT NULL)");
  }

  Future<TodoModel> insert(TodoModel model) async {
    var dbClient = await db;
    await dbClient?.insert('myTodoList', model.toMap());
    return model;
  }

  Future<List<TodoModel>> getTodoListData() async {
    await db;
    final List<Map<String, Object?>> queryResult =
        await _db!.rawQuery('SELECT * FROM myTodoList');
    return queryResult.map((e) => TodoModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!
        .delete('myTodoList', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(TodoModel model) async {
    var dbClient = await db;
    return await dbClient!.update('myTodoList', model.toMap(),
        where: 'id = ?', whereArgs: [model.id]);
  }
}
