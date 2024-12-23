import 'package:flutter_memorize/model/card.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

  Future<List<Card>> findByDeckId(int deckId) async {
    final List<Map<String, dynamic>> maps =
        await db.query("card", where: 'deck_id = ?', whereArgs: [deckId]);
    if (maps.isEmpty) return [];
    List<Card> list = List.generate(maps.length, (index) {
      return Card(
        id: maps[index]["id"],
        title: maps[index]["title"],
        desc: maps[index]["desc"],
        deckId: maps[index]["deck_id"],
      );
    });
    return list;
  }

  Future<Card?> findById(int id) async {
    List<Map> maps = await db.query("card",
        columns: ["id", "key", "value", "deck_id"],
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Card.fromMap(maps.first as Map<String, Object?>);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete("card", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteByDeckId(int deckId) async {
    return await db.delete("deck", where: 'deck_id = ?', whereArgs: [deckId]);
  }

  Future<int> update(Card card) async {
    return await db
        .update("card", card.toMap(), where: 'id = ?', whereArgs: [card.id]);
  }

  Future close() async => db.close();
}
