import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/data/repositories/deck_repository_impl.dart';
import 'package:flutter_memorize/domain/repositories/deck_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deck_provider.g.dart';

@riverpod
DeckRepository deckRepository(Ref ref) {
  return DeckRepositoryImpl();
}

@riverpod
class DeckListNotifier extends _$DeckListNotifier {
  @override
  Future<List<Deck>> build() async {
    final list = await ref.read(deckRepositoryProvider).findAll();
    return list;
  }

  Future<void> addDeck(Deck deck) async {
    await ref.read(deckRepositoryProvider).save(deck);
    final previousState = await future;
    previousState.add(deck);
    ref.notifyListeners();
  }

  Future<void> deleteDeck(Deck deck) async {
    await ref.read(deckRepositoryProvider).delete(deck.id!);
    final previousState = await future;
    previousState.remove(deck);
    ref.notifyListeners();
  }
}
