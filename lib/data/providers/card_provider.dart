import 'package:flutter_memorize/data/models/card.dart';
import 'package:flutter_memorize/data/repositories/card_repository.dart';
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
    await CardRepository().insert(card);
    ref.invalidateSelf();
    await future;
  }

  Future<void> deleteDeck(int id) async {
    await CardRepository().delete(id);
    ref.invalidateSelf();
    await future;
  }
}
