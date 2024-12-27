import 'package:flutter/material.dart';
import 'package:flutter_memorize/core/utils/common_msg.dart';
import 'package:flutter_memorize/data/models/card.dart' as m;
import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/presentation/pages/card_append_screen.dart';
import 'package:flutter_memorize/presentation/widgets/button.dart';
import 'package:flutter_memorize/presentation/widgets/text_widget.dart';
import 'package:flutter_memorize/providers/card_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeckDetailScreen extends ConsumerWidget {
  final Deck deck;
  const DeckDetailScreen({super.key, required this.deck});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<m.Card>> cardList =
        ref.watch(cardListNotifierProvider(deck.id!));
    return Scaffold(
      appBar: AppBar(
        title: const Text('카드 리스트'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              deck.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              deck.desc,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            Expanded(
              child: Center(
                child: switch (cardList) {
                  AsyncData(:final value) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          if (value.isEmpty) {
                            return const Center(child: Text('데이터가 없습니다'));
                          }
                          final card = value[index];
                          return Dismissible(
                            key: Key(card.id.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20.0),
                              color: Colors.red,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            confirmDismiss: (direction) async {
                              return await confirmDeleteShowDialog(
                                  context, "${card.title} 카드를 삭제하시겠습니까?");
                            },
                            onDismissed: (direction) async {
                              await ref
                                  .read(cardListNotifierProvider(deck.id!)
                                      .notifier)
                                  .deleteCard(card);
                              if (context.mounted) {
                                showSnackBar(
                                    context, '${card.title} 카드가 삭제되었습니다');
                              }
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      memorizeCardTitleText(text: card.title),
                                      const SizedBox(height: 8),
                                      memorizedCardDescText(text: card.desc),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  AsyncError() =>
                    const Text('Oops, something unexpected happened'),
                  _ => const CircularProgressIndicator(),
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: MemorizeFloatingActionButton(
        forwardingWidget: CardAppendScreen(
          deck: deck,
        ),
        message: "카드가 추가되었습니다.",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
