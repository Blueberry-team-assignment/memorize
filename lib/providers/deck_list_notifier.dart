import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/domain/usecases/deck_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deck_list_notifier.g.dart';

@riverpod
class DeckListNotifier extends _$DeckListNotifier {
  late final _handler = ref.read(deckUseCaseProvider);

  @override
  Future<List<Deck>> build() async {
    final list = await _handler.findAll();
    return list;
  }

  Future<void> addDeck(Deck deck) async {
    await _handler.save(deck);
    final previousState = await future;
    previousState.add(deck);
    ref.notifyListeners();
  }

  Future<void> deleteDeck(Deck deck) async {
    await _handler.delete(deck.id!);
    final previousState = await future;
    previousState.remove(deck);
    ref.notifyListeners();
  }
}
