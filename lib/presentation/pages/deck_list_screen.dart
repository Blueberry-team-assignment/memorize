import 'package:flutter/material.dart';
import 'package:flutter_memorize/core/utils/common.dart';
import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/data/providers/deck_provider.dart';
import 'package:flutter_memorize/presentation/pages/deck_append_screen.dart';
import 'package:flutter_memorize/presentation/pages/deck_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeckListScreen extends ConsumerWidget {
  const DeckListScreen({super.key});

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
                  return Dismissible(
                    key: Key(deck.id.toString()),
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
                            content: Text('${deck.title} 덱을 삭제하시겠습니까?'),
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
                          .read(deckListNotifierProvider.notifier)
                          .deleteDeck(deck.id!);
                      showSnackBar(context, '${deck.title} 덱이 삭제되었습니다');
                    },
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeckDetailScreen(deck: deck),
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
                                Text(
                                  deck.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  deck.desc,
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
                    ),
                  );
                },
              ),
            ),
          AsyncError() => const Text('Oops, something unexpected happened'),
          _ => const CircularProgressIndicator(),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final title = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeckAppendScreen(),
            ),
          );
          if (title != null) {
            showSnackBar(context, '$title 덱이 추가되었습니다');
          }
        },
        backgroundColor: Colors.grey[300],
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
