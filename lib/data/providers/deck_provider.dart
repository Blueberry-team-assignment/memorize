import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/data/repositories/deck_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deck_provider.g.dart';

@riverpod
class DeckListNotifier extends _$DeckListNotifier {
  @override
  Future<List<Deck>> build() async {
    final list = await DeckRepository().findAll();
    return list;
  }

  Future<void> addDeck(Deck deck) async {
    await DeckRepository().insert(deck);
    ref.invalidateSelf();
    await future;
  }

  Future<void> deleteDeck(int id) async {
    await DeckRepository().delete(id);
    ref.invalidateSelf();
    await future;
  }
}

@riverpod
class DeckNotifier extends _$DeckNotifier {
  @override
  Future<Deck> build(int id) async {
    final deck = await DeckRepository().findById(id);
    return deck!;
  }

  Future<void> updateDeck(Deck deck) async {
    await DeckRepository().update(deck);
    ref.invalidateSelf();
    await future;
  }
}
