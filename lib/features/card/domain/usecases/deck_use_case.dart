import 'package:flutter_memorize/common/utils/talker_service.dart';
import 'package:flutter_memorize/features/card/data/models/deck.dart';
import 'package:flutter_memorize/features/card/data/repositories/card_repository_impl.dart';
import 'package:flutter_memorize/features/card/data/repositories/deck_repository_impl.dart';
import 'package:flutter_memorize/features/card/domain/repositories/card_repository.dart';
import 'package:flutter_memorize/features/card/domain/repositories/deck_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deck_use_case.g.dart';

@riverpod
DeckUseCase deckUseCase(Ref ref) {
  DeckRepository deckRepository = ref.read(deckRepositoryProvider);
  CardRepository cardRepository = ref.read(cardRepositoryProvider);

  return DeckUseCase(
      deckRepository: deckRepository, cardRepository: cardRepository);
}

class DeckUseCase {
  final DeckRepository deckRepository;
  final CardRepository cardRepository;

  DeckUseCase({required this.deckRepository, required this.cardRepository});

  Future<int> save(Deck deck) async {
    return await deckRepository.save(deck);
  }

  Future<List<Deck>> findAll() async {
    return await deckRepository.findAll();
  }

  Future<Deck?> findById(int id) async {
    return await deckRepository.findById(id);
  }

  // TODO 트랜잭션 구현 방법 확인 하기
  Future<void> delete(int id) async {
    talker.debug("DeckUseCase.delete init");
    await deckRepository.delete(id);
    await cardRepository.deleteByDeckId(id);
    talker.debug("DeckUseCase.delete end");
  }

  Future<void> update(Deck deck) async {
    await deckRepository.update(deck);
  }
}
