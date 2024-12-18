import 'package:flutter/material.dart';
import 'package:flutter_memorize/feature/card/data/deck_data.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final DeckProvider _deckProvider = DeckProvider();

  @override
  void initState() {
    super.initState();
    _deckProvider.open('memorized.db');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Deck>>(
        future: _deckProvider.findAll(),
        initialData: const <Deck>[],
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                for (var deck in snapshot.data!)
                  Column(
                    children: [
                      Text(deck.title),
                      const SizedBox(height: 10),
                      Text(deck.desc),
                    ],
                  ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
