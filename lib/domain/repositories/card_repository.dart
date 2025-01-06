import 'package:flutter_memorize/data/models/card.dart';

abstract interface class CardRepository {
  Future<int> save(Card card);

  Future<List<Card>> findByDeckId(int deckId);

  Future<Card?> findById(int id);

  Future<void> delete(int id);

  Future<void> deleteByDeckId(int deckId);

  Future<void> update(Card card);

  Future<int> getCount(int deckId);
}
