import 'package:flutter_memorize/features/card/data/models/deck.dart';

abstract interface class DeckRepository {
  Future<int> save(Deck deck);

  Future<List<Deck>> findAll();

  Future<Deck?> findById(int id);

  Future<void> delete(int id);

  Future<void> update(Deck deck);
}
