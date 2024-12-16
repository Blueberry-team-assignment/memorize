import 'package:flutter/material.dart';
import 'package:flutter_memorize/feature/card/data/card_data.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final CardProvider _cardProvider = CardProvider();

  @override
  void initState() {
    super.initState();
    _cardProvider.open('card.db');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            print('add card');
            MemorizeCard card =
                MemorizeCard(id: 2, key: "TestKey", value: "TestValue");
            print(_cardProvider.insert(card));
            List<Map<String, Object?>> records =
                await _cardProvider.db.query('card');
            print(records.first);
          },
          // styling the button
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            // Button color
            backgroundColor: Colors.grey,
          ),
          // icon of the button
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
