import 'package:flutter_memorize/features/card/data/models/deck.dart';
import 'package:flutter_memorize/features/card/domain/usecases/deck_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deck_notifier.g.dart';

@riverpod
class DeckNotifier extends _$DeckNotifier {
  late final _handler = ref.read(deckUseCaseProvider);

  @override
  Future<Deck> build(int deckId) async {
    final deck = await _handler.findById(deckId);
    return deck!;
  }

  Future<void> updateDeck(Deck deck) async {
    await _handler.update(deck);
    ref.invalidateSelf();
    //ref.read(deckListNotifierProvider).
    await future;
  }
}

@riverpod
class DeckListNotifier extends _$DeckListNotifier {
  late final _handler = ref.read(deckUseCaseProvider);

  @override
  Future<List<Deck>> build() async {
    final list = await _handler.findAll();
    return list;
  }

  Future<void> addDeck(Deck deck) async {
    var deckId = await _handler.save(deck);
    Deck added = deck.copyWith(id: deckId);
    final previousState = await future;
    previousState.add(added);
    ref.notifyListeners();
  }

  Future<void> deleteDeck(Deck deck) async {
    await _handler.delete(deck.id!);
    final previousState = await future;
    previousState.remove(deck);
    ref.notifyListeners();
  }

  Future<void> updateDeck(Deck deck) async {
    await _handler.update(deck);
    ref.invalidateSelf();
    await future;
  }
}
