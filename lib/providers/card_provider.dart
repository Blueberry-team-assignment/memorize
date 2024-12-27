import 'package:flutter_memorize/data/models/card.dart';
import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/data/repositories/card_repository.dart';
import 'package:flutter_memorize/data/repositories/deck_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'card_provider.g.dart';

@riverpod
class CardListNotifier extends _$CardListNotifier {
  @override
  Future<List<Card>> build(int id) async {
    final list = await CardRepository().findByDeckId(id);
    return list;
  }

  Future<void> addCard(Card card) async {
    await CardRepository().save(card);
    final previousState = await future;
    previousState.add(card);
    ref.notifyListeners();
  }

  Future<void> deleteCard(Card card) async {
    await CardRepository().delete(card.id!);
    ref.invalidateSelf();
    await future;
  }
}

@riverpod
class CardNotifier extends _$CardNotifier {
  @override
  Future<Deck> build(int id) async {
    final deck = await DeckRepository().findById(id);
    return deck!;
  }
}
