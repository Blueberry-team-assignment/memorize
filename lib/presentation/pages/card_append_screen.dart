import 'package:flutter/material.dart';
import 'package:flutter_memorize/common/widget/appbar_widget.dart';
import 'package:flutter_memorize/data/models/card.dart' as m;
import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/presentation/widgets/append_form_widget.dart';
import 'package:flutter_memorize/presentation/widgets/button.dart';
import 'package:flutter_memorize/providers/card_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CardAppendScreen extends ConsumerWidget {
  final Deck deck;

  CardAppendScreen({super.key, required this.deck});

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const MemorizedAppbar(),
      body: AppendFormWidget(
          titleController: _titleController,
          contentController: _contentController),
      floatingActionButton: floatingConfirmButton(
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
          if (context.mounted) context.pop(card.title);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
