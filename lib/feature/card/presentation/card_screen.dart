import 'package:flutter/material.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print('add card');
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
