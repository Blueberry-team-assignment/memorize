import 'package:flutter_memorize/data/models/card.dart';
import 'package:flutter_memorize/domain/usecases/card_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'card_list_notifier.g.dart';

@riverpod
class CardListNotifier extends _$CardListNotifier {
  @override
  Future<List<Card>> build(int id) async {
    final list = await ref.read(cardUseCaseProvider).findByDeckId(id);
    return list;
  }

  Future<void> addCard(Card card) async {
    await ref.read(cardUseCaseProvider).save(card);
    final previousState = await future;
    previousState.add(card);
    ref.notifyListeners();
  }

  Future<void> deleteCard(Card card) async {
    await ref.read(cardUseCaseProvider).delete(card.id!);
    ref.invalidateSelf();
    await future;
  }

  Future<void> updateCard(Card card) async {
    await ref.read(cardUseCaseProvider).update(card);
    ref.invalidateSelf();
    await future;
  }
}
