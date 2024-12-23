import 'package:flutter_memorize/core/utils/database_helper.dart';
import 'package:flutter_memorize/data/models/deck.dart';

/*
final deckRepositoryProvider = Provider((_) => DeckRepository());
final decksProvider = FutureProvider((ref) {
  final deckRepository = ref.watch(deckRepositoryProvider);
  return deckRepository;
});
*/
class DeckRepository {
  final dbHelper = DatabaseHelper();

  Future<Deck> insert(Deck deck) async {
    final db = await dbHelper.database;
    deck.id = await db.insert("deck", deck.toMap());
    return deck;
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
      return Deck.fromMap(maps.first as Map<String, Object?>);
    }
    return null;
  }

  Future<int> delete(int id) async {
    final db = await dbHelper.database;
    return await db.delete("deck", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Deck deck) async {
    final db = await dbHelper.database;
    return await db
        .update("deck", deck.toMap(), where: 'id = ?', whereArgs: [deck.id]);
  }
}
