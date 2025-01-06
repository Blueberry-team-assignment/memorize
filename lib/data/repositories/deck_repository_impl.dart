import 'package:flutter_memorize/common/utils/database_helper.dart';
import 'package:flutter_memorize/common/utils/talker_service.dart';
import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/domain/repositories/deck_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deck_repository_impl.g.dart';

@riverpod
DeckRepository deckRepository(Ref ref) {
  return DeckRepositoryImpl();
}

class DeckRepositoryImpl implements DeckRepository {
  final dbHelper = DatabaseHelper();

  @override
  Future<int> save(Deck deck) async {
    final db = await dbHelper.database;
    return await db.insert("deck", deck.toJson());
  }

  @override
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

  @override
  Future<Deck?> findById(int id) async {
    final db = await dbHelper.database;
    List<Map> maps = await db.query("deck",
        columns: ["id", "title", "desc"], where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Deck.fromJson(maps.first as Map<String, Object?>);
    }
    return null;
  }

  @override
  Future<void> delete(int id) async {
    talker.debug("DeckRepository.delete by id : $id init");
    final db = await dbHelper.database;
    await db.delete("deck", where: 'id = ?', whereArgs: [id]);
    talker.debug("DeckRepository.delete by id : $id end");
  }

  @override
  Future<void> update(Deck deck) async {
    final db = await dbHelper.database;
    await db
        .update("deck", deck.toJson(), where: 'id = ?', whereArgs: [deck.id]);
  }
}
