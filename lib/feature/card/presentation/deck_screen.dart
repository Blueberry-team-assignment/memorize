import 'package:flutter/material.dart';
import 'package:flutter_memorize/feature/card/data/card_data.dart' as c;
import 'package:flutter_memorize/feature/card/data/deck_data.dart';
import 'package:flutter_memorize/feature/card/presentation/card_append_screen.dart';
import 'package:flutter_memorize/feature/card/presentation/card_screen.dart';

class DeckScreen extends StatefulWidget {
  final Deck deck;
  const DeckScreen({super.key, required this.deck});

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  final c.CardRepository _cardRepository = c.CardRepository();
  late Future<List<c.Card>> _cardListFuture;

  @override
  void initState() {
    super.initState();
    _cardListFuture = _initializeData();
  }

  Future<List<c.Card>> _initializeData() async {
    await _cardRepository.open('memorized.db');
    return _cardRepository.findByDeckId(widget.deck.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카드 리스트'),
      ),
      body: FutureBuilder<List<c.Card>>(
        future: _cardListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('에러가 발생했습니다: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('데이터가 없습니다'));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final card = snapshot.data![index];
                return InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CardScreen(
                          card: card,
                          cardRepository: _cardRepository,
                        ),
                      ),
                    );
                    setState(() {
                      _cardListFuture =
                          _cardRepository.findByDeckId(widget.deck.id!);
                    });
                  },
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            card.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            card.desc,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardAppendScreen(
                deck: widget.deck,
                cardRepository: _cardRepository,
              ),
            ),
          );
        },
        backgroundColor: Colors.grey[300],
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
