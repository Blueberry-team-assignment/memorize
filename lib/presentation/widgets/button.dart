import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppendButton extends StatelessWidget {
  const AppendButton({
    super.key,
    required Function() onPressed,
  }) : _onPressed = onPressed;

  final Function() _onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'modeAppendScreen',
      onPressed: () async {
        _onPressed();
      },
      backgroundColor: Colors.grey[300],
      child: const Icon(Icons.add),
    );
  }
}

class NavigatorBeforeButton extends StatelessWidget {
  const NavigatorBeforeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'before',
      onPressed: () => context.pop(),
      child: const Icon(Icons.navigate_before),
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
