import 'package:flutter/material.dart';
import 'package:flutter_memorize/core/utils/common.dart';
import 'package:flutter_memorize/data/models/card.dart' as m;
import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/data/providers/card_provider.dart';
import 'package:flutter_memorize/presentation/pages/card_append_screen.dart';
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
                              return await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('삭제 확인'),
                                    content: Text('${card.title} 덱을 삭제하시겠습니까?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: const Text('취소'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text('삭제'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            onDismissed: (direction) async {
                              await ref
                                  .read(cardListNotifierProvider(deck.id!)
                                      .notifier)
                                  .deleteDeck(card.id!);
                              showSnackBar(context, '${card.title} 덱이 삭제되었습니다');
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
                                      Text(
                                        card.title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        card.desc,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final title = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardAppendScreen(
                deck: deck,
              ),
            ),
          );
          if (title != null) {
            showSnackBar(context, '$title 카드가 추가되었습니다.');
          }
        },
        backgroundColor: Colors.grey[300],
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
