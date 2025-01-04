import 'package:flutter/material.dart';
import 'package:flutter_memorize/data/models/card.dart' as m;
import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/presentation/widgets/button.dart';
import 'package:flutter_memorize/presentation/widgets/text_widget.dart';
import 'package:flutter_memorize/providers/card_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardAppendScreen extends ConsumerWidget {
  final Deck deck;

  CardAppendScreen({super.key, required this.deck});

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memorize'),
        automaticallyImplyLeading: false,
      ),
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
            /*
            MemorizeAcceptButton(
              onPressed: () async {
                m.Card card = m.Card(
                  title: _titleController.text,
                  desc: _contentController.text,
                  deckId: deck.id!,
                );
                await ref
                    .read(cardListNotifierProvider(deck.id!).notifier)
                    .addCard(card);
                if (context.mounted) Navigator.pop(context, card.title);
              },
            ),
            */
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
              tagName: 'saveCard',
              onPressed: () async {
                m.Card card = m.Card(
                  title: _titleController.text,
                  desc: _contentController.text,
                  deckId: deck.id!,
                );
                await ref
                    .read(cardListNotifierProvider(deck.id!).notifier)
                    .addCard(card);
                if (context.mounted) Navigator.pop(context, card.title);
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
