import 'package:flutter/material.dart';
import 'package:flutter_memorize/common/utils/common_msg.dart';
import 'package:flutter_memorize/common/widget/async_widget.dart';
import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/presentation/widgets/button.dart';
import 'package:flutter_memorize/presentation/widgets/text_widget.dart';
import 'package:flutter_memorize/providers/deck_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeckListScreen extends ConsumerWidget {
  const DeckListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Deck>> deckList = ref.watch(deckListNotifierProvider);
    return Scaffold(
      body: Center(
        child: switch (deckList) {
          AsyncData(:final value) => _makeDeckList(value, ref),
          AsyncError() => const Error(),
          _ => const Loading(),
        },
      ),
      floatingActionButton: AppendButton(
        onPressed: () async {
          final title = await context.push("/decks/add");
          if (title != null) {
            showSnackBar(context, '$title 덱이 추가되었습니다.');
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _makeDeckList(List<Deck> value, WidgetRef ref) {
    if (value.isEmpty) {
      return const Center(child: Text('데이터가 없습니다'));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: value.length,
        itemBuilder: (context, index) {
          final deck = value[index];
          return Dismissible(
            key: Key(deck.id.toString()),
            direction: DismissDirection.endToStart,
            background: const MemorizedRedTrashIcon(),
            confirmDismiss: (direction) async {
              return await confirmDeleteShowDialog(
                  context, "${deck.title} 덱을 삭제하시겠습니까?");
            },
            onDismissed: (direction) async {
              await ref
                  .read(deckListNotifierProvider.notifier)
                  .deleteDeck(deck);
              if (context.mounted) {
                showSnackBar(context, '${deck.title} 덱이 삭제되었습니다');
              }
            },
            child: InkWell(
              onTap: () async {
                final title =
                    await context.push('/decks/${deck.id}', extra: deck);
                if (title != null) {
                  showSnackBar(context, '$title 덱이 삭제 되었습니다.');
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
                        memorizeCardTitleText(text: deck.title),
                        const SizedBox(height: 8),
                        memorizedCardDescText(text: deck.desc),
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
