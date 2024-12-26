import 'package:flutter/material.dart';

class MemorizeInputTextField extends StatelessWidget {
  const MemorizeInputTextField({
    super.key,
    required this.controller,
    required this.title,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String title;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        border: const OutlineInputBorder(),
      ),
      maxLines: maxLines,
    );
  }
}

Widget memorizeCardTitleText({required String text}) {
  return MemorizedText(
    text: text,
    size: 18,
    fontWeight: FontWeight.bold,
  );
}

Widget memorizedCardDescText({required String text}) {
  return MemorizedText(
    text: text,
    size: 14,
    fontColor: Colors.grey,
  );
}

class MemorizedText extends StatelessWidget {
  const MemorizedText({
    super.key,
    required this.text,
    this.size,
    this.fontColor = Colors.black,
    this.fontWeight = FontWeight.normal,
  });

  final String text;
  final double? size;
  final Color fontColor;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: fontColor,
        fontWeight: fontWeight,
      ),
    );
  }
}
