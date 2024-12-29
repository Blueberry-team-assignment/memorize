import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/domain/usecases/deck_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deck_list_notifier.g.dart';

@riverpod
class DeckListNotifier extends _$DeckListNotifier {
  @override
  Future<List<Deck>> build() async {
    final list = await ref.read(deckUseCaseProvider).findAll();
    return list;
  }

  Future<void> addDeck(Deck deck) async {
    await ref.read(deckUseCaseProvider).save(deck);
    final previousState = await future;
    previousState.add(deck);
    ref.notifyListeners();
  }

  Future<void> deleteDeck(Deck deck) async {
    await ref.read(deckUseCaseProvider).delete(deck.id!);
    final previousState = await future;
    previousState.remove(deck);
    ref.notifyListeners();
  }
}
