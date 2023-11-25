import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'task.dart';

const String columnId = '_id';
const String columnTitle = 'title';
const String columnIsComplete = 'isComplete';
const String columnCreatedAt = 'createdAt';

const List<String> columns = [
  columnId,
  columnTitle,
  columnIsComplete,
  columnCreatedAt,
];

class DbHelper {
  static final DbHelper instance = DbHelper._createInstance();
  static Database? _database;

  DbHelper._createInstance();

  Future<Database> get database async {
    return _database ??= await _initDB();
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'tasks.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database database, int version) async {
    await database.execute('''
      CREATE TABLE tasks('
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        isComplete BOOLEAN,
        createdAt TEXT
      )
    ''');
  }

  Future<List<Task>> selectAllTasks() async {
    final db = await instance.database;
    final tasksData = await db.query('tasks');

    return tasksData.map((json) => Task.fromJson(json)).toList();
  }

  Future<Task> taskData(int id) async {
    final db = await instance.database;
    var task = [];
    task = await db
        .query('tasks', columns: columns, where: '_id = ?', whereArgs: [id]);

    return Task.fromJson(task.first);
  }

  Future insert(Task task) async {
    final db = await database;

    return await db.insert('tasks', task.toJson());
  }

  Future update(Task task) async {
    final db = await database;

    return await db
        .update('tasks', task.toJson(), where: '_id = ?', whereArgs: [task.id]);
  }

  Future delete(int id) async {
    final db = await instance.database;

    return await db.delete('tasks', where: '_id = ?', whereArgs: [id]);
  }
}
