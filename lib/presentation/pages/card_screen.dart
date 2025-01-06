import 'package:flutter/material.dart';
import 'package:flutter_memorize/common/widget/appbar_widget.dart';
import 'package:flutter_memorize/data/models/card.dart' as m;
import 'package:flutter_memorize/presentation/widgets/append_form_widget.dart';
import 'package:flutter_memorize/presentation/widgets/button.dart';
import 'package:flutter_memorize/providers/card_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CardScreen extends ConsumerStatefulWidget {
  final m.Card card;

  const CardScreen({super.key, required this.card});

  @override
  ConsumerState<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends ConsumerState<CardScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.card.title.toString();
    _contentController.text = widget.card.desc.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MemorizedAppbar(),
      body: AppendFormWidget(
          titleController: _titleController,
          contentController: _contentController),
      floatingActionButton: floatingUpdateButton(
        tagName: 'updateDeck',
        onPressed: () async {
          m.Card updateCard = m.Card(
            id: widget.card.id,
            title: _titleController.text,
            desc: _contentController.text,
            deckId: widget.card.deckId,
          );
          await ref
              .read(cardListNotifierProvider(updateCard.deckId).notifier)
              .updateCard(updateCard);
          if (context.mounted) context.pop(updateCard.title);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
