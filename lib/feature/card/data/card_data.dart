import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Card {
  int id;
  String title;
  String desc;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{"title": title, "desc": desc};
    map["id"] = id;
    return map;
  }

  Card({
    required this.id,
    required this.title,
    required this.desc,
  });

  Card.fromMap(Map<String, Object?> map)
      : id = map["id"] as int,
        title = map["title"] as String,
        desc = map["desc"] as String;
}

class CardRepository {
  late Database db;

  Future open(String path) async {
    final dbPath = await getDatabasesPath();
    db = await openDatabase(
      join(dbPath, path),
      version: 1,
    );
  }

  Future<Card> insert(Card card) async {
    card.id = await db.insert("card", card.toMap());
    return card;
  }

  Future<List<Card>> findAll() async {
    final List<Map<String, dynamic>> maps = await db.query("card");
    if (maps.isEmpty) return [];
    List<Card> list = List.generate(maps.length, (index) {
      return Card(
        id: maps[index]["id"],
        title: maps[index]["title"],
        desc: maps[index]["desc"],
      );
    });
    return list;
  }

  Future<Card?> findById(int id) async {
    List<Map> maps = await db.query("card",
        columns: ["id", "key", "value"], where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Card.fromMap(maps.first as Map<String, Object?>);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete("card", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Card card) async {
    return await db
        .update("card", card.toMap(), where: 'id = ?', whereArgs: [card.id]);
  }

  Future close() async => db.close();
}
