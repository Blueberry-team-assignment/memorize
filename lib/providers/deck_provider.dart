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
    await DeckRepository().save(deck);
    final previousState = await future;
    previousState.add(deck);
    ref.notifyListeners();
  }

  Future<void> deleteDeck(Deck deck) async {
    await DeckRepository().delete(deck.id!);
    final previousState = await future;
    previousState.remove(deck);
    ref.notifyListeners();
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
    ref.notifyListeners();
  }
}
