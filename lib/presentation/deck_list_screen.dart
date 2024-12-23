import 'package:flutter/material.dart';
import 'package:flutter_memorize/data/models/deck.dart';
import 'package:flutter_memorize/data/repositories/deck_repository.dart';
import 'package:flutter_memorize/presentation/deck_append_screen.dart';
import 'package:flutter_memorize/presentation/deck_screen.dart';

import '../core/utils/talker_service.dart';

class DeckListScreen extends StatefulWidget {
  const DeckListScreen({super.key});

  @override
  State<DeckListScreen> createState() => _DeckListScreenState();
}

class _DeckListScreenState extends State<DeckListScreen> {
  late final DeckRepository _deckRepository = DeckRepository();
  late Future<List<Deck>> _deckListFuture;

  @override
  void initState() {
    talker.debug("DeckListScreen.initState init");
    super.initState();
    _deckListFuture = _initializeData();
    talker.debug("DeckListScreen.initState end");
  }

  Future<List<Deck>> _initializeData() async {
    talker.debug("DeckListScreen._initializeData init");
    return _deckRepository.findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Deck>>(
        future: _deckListFuture,
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
                final deck = snapshot.data![index];
                return Dismissible(
                  key: Key(deck.id.toString()),
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
                          content: Text('${deck.title} 덱을 삭제하시겠습니까?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('취소'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('삭제'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (direction) async {
                    await _deckRepository.delete(deck.id!);
                    setState(() {
                      snapshot.data!.removeAt(index);
                    });
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${deck.title} 덱이 삭제되었습니다')),
                    );
                  },
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeckScreen(deck: deck),
                        ),
                      );
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
                                deck.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                deck.desc,
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final title = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeckAppendScreen(
                deckProvider: _deckRepository,
              ),
            ),
          );
          if (title != null) {
            setState(() {
              _deckListFuture = _deckRepository.findAll();
            });
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$title 덱이 추가되었습니다')),
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
