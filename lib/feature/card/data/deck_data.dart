import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Deck {
  int? id;
  String title;
  String desc;

  Deck({
    this.id,
    required this.title,
    required this.desc,
  });

  Map<String, Object?> toMap() {
    var map = <String, Object?>{"title": title, "desc": desc};
    map["id"] = id;
    return map;
  }

  Deck.fromMap(Map<String, Object?> map)
      : id = map["id"] as int,
        title = map["title"] as String,
        desc = map["desc"] as String;
}

class DeckProvider {
  late Database db;

  Future open(String path) async {
    final dbPath = await getDatabasesPath();
    db = await openDatabase(
      join(dbPath, path),
      onCreate: (Database db, int version) async {
        await db.execute(
            'create table deck (id integer primary key autoincrement, title text not null, desc text)');
      },
      version: 1,
    );
  }

  Future<Deck> insert(Deck deck) async {
    deck.id = await db.insert("deck", deck.toMap());
    return deck;
  }

  Future<List<Deck>> findAll() async {
    final List<Map<String, dynamic>> maps = await db.query("deck");
    if (maps.isEmpty) return [];
    List<Deck> list = List.generate(maps.length, (index) {
      return Deck(
        id: maps[index]["id"],
        title: maps[index]["title"],
        desc: maps[index]["desc"],
      );
    });
    return list;
  }

  Future<Deck?> findById(int id) async {
    List<Map> maps = await db.query("deck",
        columns: ["id", "title", "desc"], where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Deck.fromMap(maps.first as Map<String, Object?>);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete("deck", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Deck deck) async {
    return await db
        .update("deck", deck.toMap(), where: 'id = ?', whereArgs: [deck.id]);
  }

  Future close() async => db.close();
}
