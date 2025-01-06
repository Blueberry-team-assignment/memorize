import 'package:flutter_memorize/common/utils/database_helper.dart';
import 'package:flutter_memorize/common/utils/talker_service.dart';
import 'package:flutter_memorize/data/models/card.dart';
import 'package:flutter_memorize/domain/repositories/card_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'card_repository_impl.g.dart';

@riverpod
CardRepository cardRepository(Ref ref) {
  return CardRepositoryImpl();
}

class CardRepositoryImpl implements CardRepository {
  final dbHelper = DatabaseHelper();

  @override
  Future<int> save(Card card) async {
    final db = await dbHelper.database;
    return await db.insert("card", card.toJson());
  }

  @override
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

  @override
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

  @override
  Future<void> delete(int id) async {
    final db = await dbHelper.database;
    await db.delete("card", where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> deleteByDeckId(int deckId) async {
    talker.debug("CardRepositoryImpl.deleteByDeckId init : deck id $deckId");
    final db = await dbHelper.database;
    await db.delete("card", where: 'deckId = ?', whereArgs: [deckId]);
    talker.debug("CardRepositoryImpl.deleteByDeckId end : deck id $deckId");
  }

  @override
  Future<void> update(Card card) async {
    final db = await dbHelper.database;
    await db
        .update("card", card.toJson(), where: 'id = ?', whereArgs: [card.id]);
  }

  @override
  Future<int> getCount(int deckId) async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT COUNT (*) from card where = ?', [deckId]);
    return Sqflite.firstIntValue(result)!;
  }
}
