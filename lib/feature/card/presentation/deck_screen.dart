import 'package:flutter/material.dart';
import 'package:flutter_memorize/feature/card/data/card_repository.dart';
import 'package:flutter_memorize/feature/card/data/deck_data.dart';
import 'package:flutter_memorize/feature/card/presentation/card_append_screen.dart';
import 'package:flutter_memorize/feature/card/presentation/card_screen.dart';
import 'package:flutter_memorize/model/card.dart' as m;

class DeckScreen extends StatefulWidget {
  final Deck deck;
  const DeckScreen({super.key, required this.deck});

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  final CardRepository _cardRepository = CardRepository();
  late Future<List<m.Card>> _cardListFuture;

  @override
  void initState() {
    super.initState();
    _cardListFuture = _initializeData();
  }

  Future<List<m.Card>> _initializeData() async {
    await _cardRepository.open('memorized.db');
    return _cardRepository.findByDeckId(widget.deck.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카드 리스트'),
      ),
      body: FutureBuilder<List<m.Card>>(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  widget.deck.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.deck.desc,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 1),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final card = snapshot.data![index];
                      return Dismissible(
                        key: Key(card.id.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        confirmDismiss: (direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('삭제 확인'),
                                content: const Text('이 카드를 삭제하시겠습니까?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text('취소'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text('삭제'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onDismissed: (direction) async {
                          await _cardRepository.delete(card.id!);
                          setState(() {
                            snapshot.data!.removeAt(index);
                          });
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${card.title} 덱이 삭제되었습니다')),
                          );
                        },
                        child: InkWell(
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
                          child: SizedBox(
                            width: double.infinity,
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
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final title = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardAppendScreen(
                deck: widget.deck,
                cardRepository: _cardRepository,
              ),
            ),
          );
          if (title != null) {
            setState(() {
              _cardListFuture = _cardRepository.findByDeckId(widget.deck.id!);
            });
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$title 카드가 추가되었습니다')),
            );
          }
        },
        backgroundColor: Colors.grey[300],
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
