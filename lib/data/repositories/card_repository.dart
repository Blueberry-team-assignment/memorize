import 'package:flutter_memorize/core/utils/database_helper.dart';
import 'package:flutter_memorize/core/utils/talker_service.dart';
import 'package:flutter_memorize/data/models/card.dart';

class CardRepository {
  final dbHelper = DatabaseHelper();

  Future<void> insert(Card card) async {
    talker.debug("CardRepository.insert : $card init");
    final db = await dbHelper.database;
    await db.insert("card", card.toJson());
    talker.debug("CardRepository.insert : $card end");
  }

  Future<List<Card>> findByDeckId(int deckId) async {
    talker.debug("CardRepository.findByDeckId init {$deckId}");
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query("card", where: 'deckId = ?', whereArgs: [deckId]);
    if (maps.isEmpty) return [];
    talker.debug(maps);
    List<Card> list = List.generate(maps.length, (index) {
      return Card(
        id: maps[index]["id"],
        title: maps[index]["title"],
        desc: maps[index]["desc"],
        deckId: maps[index]["deckId"],
      );
    });
    talker.debug("CardRepository.findByDeckId end {$deckId}");
    return list;
  }

  Future<Card?> findById(int id) async {
    final db = await dbHelper.database;
    List<Map> maps = await db.query("card",
        columns: ["id", "key", "value", "deckId"],
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Card.fromJson(maps.first as Map<String, Object?>);
    }
    return null;
  }

  Future<void> delete(int id) async {
    final db = await dbHelper.database;
    await db.delete("card", where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteByDeckId(int deckId) async {
    final db = await dbHelper.database;
    await db.delete("deck", where: 'deckId = ?', whereArgs: [deckId]);
  }

  Future<void> update(Card card) async {
    final db = await dbHelper.database;
    await db
        .update("card", card.toJson(), where: 'id = ?', whereArgs: [card.id]);
  }
}
