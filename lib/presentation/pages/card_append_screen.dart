import 'package:flutter/material.dart';
import 'package:flutter_memorize/data/models/card.dart' as m;
import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/data/repositories/card_repository.dart';

class CardAppendScreen extends StatefulWidget {
  final Deck deck;
  final CardRepository cardRepository;

  const CardAppendScreen(
      {super.key, required this.deck, required this.cardRepository});

  @override
  State<CardAppendScreen> createState() => _CardAppendScreenState();
}

class _CardAppendScreenState extends State<CardAppendScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

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
        title: const Text('새로운 카드 추가'),
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
            const Spacer(),
            Container(
              width: double.infinity,
              height: 55,
              margin: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: () async {
                  m.Card card = m.Card(
                    title: _titleController.text,
                    desc: _contentController.text,
                    deckId: widget.deck.id!,
                  );
                  await widget.cardRepository.insert(card);
                  Navigator.pop(context, _titleController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[900],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  shadowColor: Theme.of(context).primaryColor.withOpacity(0.5),
                ),
                child: const Text(
                  '등록하기',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
