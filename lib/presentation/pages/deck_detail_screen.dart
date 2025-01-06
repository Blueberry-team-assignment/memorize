import 'package:flutter/material.dart';
import 'package:flutter_memorize/common/utils/common_msg.dart';
import 'package:flutter_memorize/common/utils/talker_service.dart';
import 'package:flutter_memorize/common/widget/async_widget.dart';
import 'package:flutter_memorize/data/models/card.dart' as m;
import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/presentation/widgets/button.dart';
import 'package:flutter_memorize/presentation/widgets/text_widget.dart';
import 'package:flutter_memorize/providers/card_list_notifier.dart';
import 'package:flutter_memorize/providers/deck_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeckDetailScreen extends ConsumerWidget {
  final Deck deck;
  const DeckDetailScreen({super.key, required this.deck});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<m.Card>> cardList =
        ref.watch(cardListNotifierProvider(deck.id!));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  deck.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.green,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        var isDeleted = await confirmDeleteShowDialog(
                            context, "${deck.title} 덱을 삭제하시겠습니까?");
                        talker.debug("is Delete {$isDeleted}");
                        if (isDeleted!) {
                          await ref
                              .read(deckListNotifierProvider.notifier)
                              .deleteDeck(deck);
                          if (context.mounted) {
                            context.pop(deck.title);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
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
                  AsyncData(:final value) => _makeCardList(value, ref),
                  AsyncError() => const Error(),
                  _ => const Loading(),
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const NavigatorBeforeButton(),
            AppendButton(
              onPressed: () async {
                final title = await context.push('/cards/add', extra: deck);
                if (title != null) {
                  showSnackBar(context, '$title 카드가 추가되었습니다.');
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  Widget _makeCardList(List<m.Card> value, WidgetRef ref) {
    if (value.isEmpty) {
      return const Center(child: Text('데이터가 없습니다'));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: value.length,
        itemBuilder: (context, index) {
          final card = value[index];
          return InkWell(
            onTap: () async {
              final title =
                  await context.push('/cards/${card.id}', extra: card);
              if (title != null) {
                showSnackBar(context, '$title 카드가 수정되었습니다.');
              }
            },
            child: Dismissible(
              key: Key(card.id.toString()),
              direction: DismissDirection.endToStart,
              background: const MemorizedRedTrashIcon(),
              confirmDismiss: (direction) async {
                return await confirmDeleteShowDialog(
                    context, "${card.title} 카드를 삭제하시겠습니까?");
              },
              onDismissed: (direction) async {
                await ref
                    .read(cardListNotifierProvider(deck.id!).notifier)
                    .deleteCard(card);
                if (context.mounted) {
                  showSnackBar(context, '${card.title} 카드가 삭제되었습니다');
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        memorizeCardTitleText(text: card.title),
                        const SizedBox(height: 8),
                        memorizedCardDescText(text: card.desc),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
