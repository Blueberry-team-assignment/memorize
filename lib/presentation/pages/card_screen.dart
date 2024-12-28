import 'package:flutter/material.dart';
import 'package:flutter_memorize/data/models/card.dart' as m;
import 'package:flutter_memorize/data/repositories/card_repository_impl.dart';

class CardScreen extends StatefulWidget {
  final m.Card card;
  final CardRepositoryImpl cardRepository;

  const CardScreen(
      {super.key, required this.card, required this.cardRepository});

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
        title: const Text('Card'),
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
              height: 55,
              margin: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: () async {
                  m.Card card = m.Card(
                    id: widget.card.id!,
                    title: _titleController.text,
                    desc: _contentController.text,
                    deckId: widget.card.deckId,
                  );
                  await widget.cardRepository.update(card);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[900],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  shadowColor: Colors.grey[900]?.withOpacity(0.5),
                ),
                child: const Text(
                  '수정',
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
