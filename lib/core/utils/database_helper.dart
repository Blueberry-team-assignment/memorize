import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  Database? _db;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase('memorized.db');
    return _db!;
  }

  Future<Database> _initDatabase(String path) async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, path),
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'create table deck ( id integer primary key autoincrement, title text not null, desc text not null)');
    await db.execute(
        'create table card ( id integer primary key autoincrement, title text not null, desc text not null, deck_id integer not null)');
  }
}
