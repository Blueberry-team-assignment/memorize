import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  Future<Database> create(String path) async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, path),
      onCreate: (Database db, int version) async {
        await db.execute(
            'create table deck ( id integer primary key autoincrement, title text not null, desc text not null)');
        await db.execute(
            'create table card ( id integer primary key autoincrement, title text not null, desc text not null)');
      },
      version: 1,
    );
  }
}
