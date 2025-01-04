import 'package:flutter/material.dart';
import 'package:flutter_memorize/data/models/card.dart' as m;
import 'package:flutter_memorize/presentation/widgets/button.dart';

class CardScreen extends StatefulWidget {
  final m.Card card;

  const CardScreen({super.key, required this.card});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.card.title.toString();
    _contentController.text = widget.card.desc.toString();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            // 제목 입력
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '제목',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // 내용 입력
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: '내용',
                border: OutlineInputBorder(),
              ),
              maxLines: 10,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const NavigatorBeforeButton(),
            FloatingActionButton(
              heroTag: 'updataCard',
              onPressed: () {
                m.Card card = m.Card(
                  id: widget.card.id!,
                  title: _titleController.text,
                  desc: _contentController.text,
                  deckId: widget.card.deckId,
                );
                //await widget.cardRepository.update(card);
              },
              backgroundColor: Colors.amberAccent,
              child: const Icon(Icons.update),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
