import 'package:flutter/material.dart';

class DeckScreen extends StatefulWidget {
  const DeckScreen({super.key});

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  //final CardProvider _cardProvider = CardProvider();

  @override
  void initState() {
    super.initState();
    //_cardProvider.open('card.db');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deck Management'),
      ),
      body: Container(),
    );
  }
}
