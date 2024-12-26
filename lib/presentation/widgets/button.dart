import 'package:flutter/material.dart';
import 'package:flutter_memorize/core/utils/common_msg.dart';

class MemorizeFloatingActionButton extends StatelessWidget {
  final Widget forwardingWidget;
  final String message;

  const MemorizeFloatingActionButton({
    super.key,
    required this.forwardingWidget,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final title = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => forwardingWidget,
          ),
        );
        if (title != null) {
          showSnackBar(context, '$title $message');
        }
      },
      backgroundColor: Colors.grey[300],
      child: const Icon(Icons.add),
    );
  }
}

class MemorizeAcceptButton extends StatelessWidget {
  const MemorizeAcceptButton({
    super.key,
    required Function() onPressed,
  }) : _onPressed = onPressed;

  final Function() _onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      margin: const EdgeInsets.only(bottom: 16),
      child: ElevatedButton(
        onPressed: () async {
          _onPressed();
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
    );
  }
}
