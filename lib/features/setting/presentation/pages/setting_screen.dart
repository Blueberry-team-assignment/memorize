import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Text(
              '암기 시간',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                //controller: _titleController,
                decoration: InputDecoration(
                  labelText: '카드가 뒤집힐 시간을 설정하세요.',
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
