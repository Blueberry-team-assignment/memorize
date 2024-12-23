import 'package:flutter/material.dart';
import 'package:flutter_memorize/model/deck.dart';
import 'package:flutter_memorize/repository/deck_data.dart';

class DeckAppendScreen extends StatefulWidget {
  final DeckRepository deckProvider;

  const DeckAppendScreen({super.key, required this.deckProvider});

  @override
  State<DeckAppendScreen> createState() => _DeckAppendScreenState();
}

class _DeckAppendScreenState extends State<DeckAppendScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  late final DeckRepository _deckProvider;

  @override
  void initState() {
    super.initState();
    _deckProvider = widget.deckProvider;
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
        title: const Text('새로운 덱 추가'),
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
                  Deck deck = Deck(
                      title: _titleController.text,
                      desc: _contentController.text);
                  await _deckProvider.insert(deck);
                  Navigator.pop(context, _titleController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[900],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
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
