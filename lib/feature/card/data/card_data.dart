import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MemorizeCard {
  int id;
  String key;
  String value;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{"key": key, "value": value};
    map["id"] = id;
    return map;
  }

  MemorizeCard({
    required this.id,
    required this.key,
    required this.value,
  });

  MemorizeCard.fromMap(Map<String, Object?> map)
      : id = map["id"] as int,
        key = map["key"] as String,
        value = map["value"] as String;
}

class CardProvider {
  late Database db;

  Future open(String path) async {
    final dbPath = await getDatabasesPath();
    print("db path :$dbPath");
    db = await openDatabase(
      join(dbPath, path),
      onCreate: (Database db, int version) async {
        await db.execute(
            'create table card ( id integer primary key autoincrement, key text not null, value text not null)');
      },
      version: 1,
    );
  }

  Future<MemorizeCard> insert(MemorizeCard card) async {
    card.id = await db.insert("card", card.toMap());
    return card;
  }

  Future<MemorizeCard?> getTodo(int id) async {
    List<Map> maps = await db.query("card",
        columns: ["id", "key", "value"], where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return MemorizeCard.fromMap(maps.first as Map<String, Object?>);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete("card", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(MemorizeCard card) async {
    return await db
        .update("card", card.toMap(), where: 'id = ?', whereArgs: [card.id]);
  }

  Future close() async => db.close();
}
