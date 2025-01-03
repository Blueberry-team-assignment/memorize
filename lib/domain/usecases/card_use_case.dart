import 'package:flutter_memorize/data/models/card.dart';
import 'package:flutter_memorize/data/repositories/card_repository_impl.dart';
import 'package:flutter_memorize/domain/repositories/card_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'card_use_case.g.dart';

@riverpod
CardUseCase cardUseCase(Ref ref) {
  CardRepository cardRepository = ref.read(cardRepositoryProvider);

  return CardUseCase(cardRepository: cardRepository);
}

class CardUseCase {
  final CardRepository cardRepository;

  CardUseCase({required this.cardRepository});

  Future<void> save(Card card) async {
    await cardRepository.save(card);
  }

  Future<List<Card>> findByDeckId(int deckId) async {
    return await cardRepository.findByDeckId(deckId);
  }

  Future<Card?> findById(int id) async {
    return await cardRepository.findById(id);
  }

  Future<void> delete(int id) async {
    await cardRepository.delete(id);
  }

  Future<void> update(Card card) async {
    await cardRepository.update(card);
  }

  Future<int> getCount(int deckId) async {
    return await cardRepository.getCount(deckId);
  }
}
