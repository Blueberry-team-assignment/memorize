import 'package:flutter/material.dart';
import 'package:flutter_memorize/data/models/card.dart' as m;
import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/providers/card_provider.dart';
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
        AsyncData(:final value) => ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            itemCount: value.length,
            itemBuilder: (context, index) {
              var card = value[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Container(
                  width: 350,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          offset: const Offset(10, 10),
                          color: Colors.black.withOpacity(0.5),
                        )
                      ]),
                  child: Card(
                    child: Center(
                      child: Text(
                        card.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 40,
            ),
          ),
        Error() => const Text('Oops, something unexpected happened'),
        _ => const CircularProgressIndicator(),
      }),
    );
  }
}
