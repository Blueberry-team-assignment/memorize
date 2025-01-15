import 'package:flutter_memorize/features/card/data/models/card.dart';
import 'package:flutter_memorize/features/card/domain/usecases/card_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'card_notifier.g.dart';

@riverpod
class CardListNotifier extends _$CardListNotifier {
  late final _handler = ref.read(cardUseCaseProvider);

  @override
  Future<List<Card>> build(int id) async {
    final list = await _handler.findByDeckId(id);
    return list;
  }

  Future<void> addCard(Card card) async {
    var cardId = await _handler.save(card);
    Card added = card.copyWith(id: cardId);
    final previousState = await future;
    previousState.add(added);
    ref.notifyListeners();
  }

  Future<void> deleteCard(Card card) async {
    await _handler.delete(card.id!);
    ref.invalidateSelf();
    await future;
  }

  Future<void> updateCard(Card card) async {
    await _handler.update(card);
    ref.invalidateSelf();
    await future;
  }
}
