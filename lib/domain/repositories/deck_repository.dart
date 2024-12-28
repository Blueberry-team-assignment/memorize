import 'package:flutter_memorize/data/models/deck.dart';

abstract interface class DeckRepository {
  Future<void> save(Deck deck);

  Future<List<Deck>> findAll();

  Future<Deck?> findById(int id);

  Future<void> delete(int id);

  Future<void> update(Deck deck);
}
