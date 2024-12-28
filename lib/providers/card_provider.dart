import 'package:flutter_memorize/data/models/card.dart';
import 'package:flutter_memorize/data/repositories/card_repository_impl.dart';
import 'package:flutter_memorize/domain/repositories/card_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'card_provider.g.dart';

@riverpod
CardRepository cardRepository(Ref ref) {
  return CardRepositoryImpl();
}

@riverpod
class CardListNotifier extends _$CardListNotifier {
  @override
  Future<List<Card>> build(int id) async {
    final list = await ref.read(cardRepositoryProvider).findByDeckId(id);
    return list;
  }

  Future<void> addCard(Card card) async {
    await ref.read(cardRepositoryProvider).save(card);
    final previousState = await future;
    previousState.add(card);
    ref.notifyListeners();
  }

  Future<void> deleteCard(Card card) async {
    await ref.read(cardRepositoryProvider).delete(card.id!);
    ref.invalidateSelf();
    await future;
  }
}
