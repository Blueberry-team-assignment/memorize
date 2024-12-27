import 'package:flutter/material.dart';
import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/presentation/pages/memorize_screen.dart';
import 'package:flutter_memorize/presentation/widgets/text_widget.dart';
import 'package:flutter_memorize/providers/deck_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MemorizeListScreen extends ConsumerWidget {
  const MemorizeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Deck>> deckList = ref.watch(deckListNotifierProvider);
    return Scaffold(
      body: Center(
        child: switch (deckList) {
          AsyncData(:final value) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  if (value.isEmpty) {
                    return const Center(child: Text('데이터가 없습니다'));
                  }
                  final deck = value[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MemorizeScreen(deck: deck),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              memorizeCardTitleText(text: deck.title),
                              const SizedBox(height: 8),
                              memorizedCardDescText(text: deck.desc)
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          AsyncError() => const Text('Oops, something unexpected happened'),
          _ => const CircularProgressIndicator(),
        },
      ),
    );
  }
}
