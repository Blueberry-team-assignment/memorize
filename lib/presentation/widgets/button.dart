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

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    super.key,
    required String tagName,
    required Function() onPressed,
  })  : _tagName = tagName,
        _onPressed = onPressed;

  final String _tagName;
  final Function() _onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: _tagName,
      onPressed: () async {
        await _onPressed();
      },
      backgroundColor: Colors.green,
      child: const Icon(Icons.check),
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
