import 'package:flutter_memorize/core/utils/database_helper.dart';
import 'package:flutter_memorize/core/utils/talker_service.dart';
import 'package:flutter_memorize/data/models/deck.dart';

class DeckRepository {
  final dbHelper = DatabaseHelper();

  Future<void> save(Deck deck) async {
    try {
      final db = await DatabaseHelper().database;
      await db.insert("deck", deck.toJson());
    } catch (e) {
      talker.error("DeckRepository.save $e");
    }
  }

  Future<List<Deck>> findAll() async {
    final db = await dbHelper.database;
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
    final db = await dbHelper.database;
    List<Map> maps = await db.query("deck",
        columns: ["id", "title", "desc"], where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Deck.fromJson(maps.first as Map<String, Object?>);
    }
    return null;
  }

  Future<void> delete(int id) async {
    talker.debug("DeckRepository.delete by id : $id init");
    final db = await dbHelper.database;
    await db.delete("deck", where: 'id = ?', whereArgs: [id]);
    talker.debug("DeckRepository.delete by id : $id end");
  }

  Future<void> update(Deck deck) async {
    final db = await dbHelper.database;
    await db
        .update("deck", deck.toJson(), where: 'id = ?', whereArgs: [deck.id]);
  }
}
