import 'package:animated_flip_widget/animated_flip_widget/flip_controler.dart';
import 'package:animated_flip_widget/animated_flip_widget/flip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memorize/data/models/card.dart' as m;
import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/data/providers/card_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MemorizeScreen extends ConsumerWidget {
  final Deck deck;
  final _controller = FlipController();
  MemorizeScreen({super.key, required this.deck});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<m.Card>> cardList =
        ref.watch(cardListNotifierProvider(deck.id!));
    return Scaffold(
      appBar: AppBar(
        title: Text('${deck.title} memorizing'),
      ),
      body: InkWell(
        onTap: () => _controller.flip(),
        child: Center(
            child: switch (cardList) {
          AsyncData(:final value) => AnimatedFlipWidget(
              front: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Card(
                    color: Colors.grey[300],
                    child: Center(
                      child: Text(
                        value[0].title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              back: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Card(
                    color: Colors.grey[300],
                    child: Center(
                      child: Text(
                        value[0].desc,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              controller: _controller,
              clickable: true,
              flipDuration: const Duration(milliseconds: 300),
              flipDirection: FlipDirection.horizontal,
            ),
          Error() => const Text('Oops, something unexpected happened'),
          _ => const CircularProgressIndicator(),
        }),
      ),
    );
  }
}
