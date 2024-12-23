import 'package:flutter_memorize/core/utils/database_helper.dart';
import 'package:flutter_memorize/data/models/card.dart';

class CardRepository {
  final dbHelper = DatabaseHelper();

  Future<Card> insert(Card card) async {
    final db = await dbHelper.database;
    card.id = await db.insert("card", card.toMap());
    return card;
  }

  Future<List<Card>> findByDeckId(int deckId) async {
    final db = await dbHelper.database;
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
    final db = await dbHelper.database;
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
    final db = await dbHelper.database;
    return await db.delete("card", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteByDeckId(int deckId) async {
    final db = await dbHelper.database;
    return await db.delete("deck", where: 'deck_id = ?', whereArgs: [deckId]);
  }

  Future<int> update(Card card) async {
    final db = await dbHelper.database;
    return await db
        .update("card", card.toMap(), where: 'id = ?', whereArgs: [card.id]);
  }
}
