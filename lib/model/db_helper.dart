import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'task.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._createInstance();
  static Database? _database;

  DbHelper._createInstance();

  Future<Database> get database async {
    return _database ??= await _initDB();
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'ynymportal.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database database, int version) async {
    await database.execute('''
      CREATE TABLE tasks(
        id TEXT PRIMARY KEY,
        title TEXT
      )
    ''');
  }

  Future<List<Task>> getTasks() async {
    final db = await instance.database;
    final tasks = await db.query('tasks');

    return tasks.map((json) => Task.fromMap(json)).toList();
  }

  Future<Task> getTask(String id) async {
    final db = await instance.database;
    final List<Map<String, Object?>> task = await db.query('tasks',
        where: 'id = ?', whereArgs: [id]);

    return Task.fromMap(task.first);
  }

  Future insert(Task task) async {
    final db = await database;

    return await db.insert('tasks', task.toMap());
  }

  Future update(Task task) async {
    final db = await database;

    return await db
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future delete(String id) async {
    final db = await instance.database;

    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
