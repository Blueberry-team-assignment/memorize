import 'package:flutter/material.dart';
import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/presentation/widgets/button.dart';
import 'package:flutter_memorize/presentation/widgets/text_widget.dart';
import 'package:flutter_memorize/providers/deck_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeckAppendScreen extends ConsumerWidget {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  DeckAppendScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MemorizeInputTextField(
              controller: _titleController,
              title: "제목",
            ),
            const SizedBox(height: 16),
            MemorizeInputTextField(
              controller: _contentController,
              title: '내용',
              maxLines: 10,
            ),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const NavigatorBeforeButton(),
            ConfirmButton(
              tagName: 'saveDeck',
              onPressed: () async {
                Deck deck = Deck(
                  title: _titleController.text,
                  desc: _contentController.text,
                );
                await ref.read(deckListNotifierProvider.notifier).addDeck(deck);

                if (context.mounted) context.pop(deck.title);
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
