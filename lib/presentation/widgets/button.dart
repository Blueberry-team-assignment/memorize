import 'package:flutter/material.dart';
import 'package:flutter_memorize/common/utils/common_msg.dart';

class MemorizeFloatingActionButton extends StatelessWidget {
  const MemorizeFloatingActionButton({
    super.key,
    required String message,
    required Function() onPressed,
  })  : _message = message,
        _onPressed = onPressed;

  final String _message;
  final Function() _onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        /*
        final title = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => forwardingWidget,
          ),
        );
        */
        //final title = await context.push("/decks/add");
        final title = await _onPressed();
        if (title != null) {
          showSnackBar(context, '$title $_message');
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

class MemorizedRedTrashIcon extends StatelessWidget {
  const MemorizedRedTrashIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}
