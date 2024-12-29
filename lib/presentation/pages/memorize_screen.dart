import 'package:flutter/material.dart';
import 'package:flutter_memorize/data/models/card.dart' as m;
import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/providers/card_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MemorizeScreen extends ConsumerWidget {
  final Deck deck;
  const MemorizeScreen({super.key, required this.deck});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<m.Card>> cardList =
        ref.watch(cardListNotifierProvider(deck.id!));
    return Scaffold(
      appBar: AppBar(
        title: Text('${deck.title} memorizing'),
      ),
      body: Center(
          child: switch (cardList) {
        AsyncData(:final value) => _MemorizeList(cardList: value),
        Error() => const Text('Oops, something unexpected happened'),
        _ => const CircularProgressIndicator(),
      }),
    );
  }
}

class _MemorizeList extends StatelessWidget {
  const _MemorizeList({
    required this.cardList,
  });

  final List<m.Card> cardList;

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(4, 10, 4, 60),
      width: double.infinity,
      height: double.infinity,
      child: PageView.builder(
        controller: controller,
        itemCount: cardList.length,
        itemBuilder: (context, index) {
          var card = cardList[index];
          return Container(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 6,
                      spreadRadius: 3,
                      offset: const Offset(0, 0))
                ]),
            child: Text(card.title),
          );
        },
      ),
    );
  }
}
