import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String table = 'card';
const String columnId = '_id';
const String columnKey = 'key';
const String columnValue = 'value';

class MemorizeCard {
  int id;
  String key;
  String value;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{columnKey: key, columnValue: value};
    map[columnId] = id;
    return map;
  }

  MemorizeCard({
    required this.id,
    required this.key,
    required this.value,
  });

  MemorizeCard.fromMap(Map<String, Object?> map)
      : id = map[columnId] as int,
        key = map[columnKey] as String,
        value = map[columnValue] as String;
}

class CardProvider {
  late Database db;

  Future open(String path) async {
    final dbPath = await getDatabasesPath();
    db = await openDatabase(
      join(dbPath, path),
      onCreate: (Database db, int version) async {
        await db.execute('''create table $table ( 
                            $columnId integer primary key autoincrement, 
                            $columnKey text not null,
                            $columnValue text not null)
                      ''');
      },
      version: 1,
    );
  }

  Future<MemorizeCard> insert(MemorizeCard card) async {
    card.id = await db.insert(table, card.toMap());
    return card;
  }

  Future<MemorizeCard?> getTodo(int id) async {
    List<Map> maps = await db.query(table,
        columns: [columnId, columnKey, columnValue],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return MemorizeCard.fromMap(maps.first as Map<String, Object?>);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(MemorizeCard card) async {
    return await db.update(table, card.toMap(),
        where: '$columnId = ?', whereArgs: [card.id]);
  }

  Future close() async => db.close();
}
