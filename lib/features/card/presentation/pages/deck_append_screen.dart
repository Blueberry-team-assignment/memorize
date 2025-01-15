import 'package:flutter/material.dart';
import 'package:flutter_memorize/features/card/data/models/deck.dart';
import 'package:flutter_memorize/features/card/presentation/providers/deck_notifier.dart';
import 'package:flutter_memorize/features/card/presentation/widgets/append_form_widget.dart';
import 'package:flutter_memorize/features/card/presentation/widgets/button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeckAppendScreen extends ConsumerWidget {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  DeckAppendScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: AppendFormWidget(
          titleController: _titleController,
          contentController: _contentController),
      floatingActionButton: floatingConfirmButton(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
