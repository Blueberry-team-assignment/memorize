import 'package:flutter/material.dart';
import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/presentation/widgets/append_form_widget.dart';
import 'package:flutter_memorize/presentation/widgets/button.dart';
import 'package:flutter_memorize/providers/deck_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeckUpdateScreen extends ConsumerStatefulWidget {
  final Deck _deck;

  const DeckUpdateScreen({
    super.key,
    required Deck deck,
  }) : _deck = deck;

  @override
  ConsumerState<DeckUpdateScreen> createState() => _DeckUpdateScreenState();
}

class _DeckUpdateScreenState extends ConsumerState<DeckUpdateScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget._deck.title.toString();
    _contentController.text = widget._deck.desc.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppendFormWidget(
          titleController: _titleController,
          contentController: _contentController),
      floatingActionButton: floatingUpdateButton(
        tagName: 'updateDeck',
        onPressed: () async {
          Deck updatedDeck = Deck(
            id: widget._deck.id,
            title: _titleController.text,
            desc: _contentController.text,
          );

          await ref
              .read(deckListNotifierProvider.notifier)
              .updateDeck(updatedDeck);
          if (context.mounted) context.pop(updatedDeck.title);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
