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

Widget floatingConfirmButton(
    {required tagName, required Function() onPressed}) {
  return MemorizedFloatingButton(
    tagName: tagName,
    onPressed: onPressed,
    backgroundColor: Colors.green,
    icon: const Icon(Icons.check),
  );
}

/*
class FloatingConfirmButton extends StatelessWidget {
  const FloatingConfirmButton({
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
*/

Widget floatingUpdateButton({required tagName, required Function() onPressed}) {
  return MemorizedFloatingButton(
    tagName: tagName,
    onPressed: onPressed,
    backgroundColor: Colors.amberAccent,
    icon: const Icon(Icons.update),
  );
}

class MemorizedFloatingButton extends StatelessWidget {
  const MemorizedFloatingButton({
    super.key,
    required String tagName,
    required Function() onPressed,
    required Color backgroundColor,
    required Icon icon,
  })  : _tagName = tagName,
        _onPressed = onPressed,
        _backgroundColor = backgroundColor,
        _icon = icon;

  final String _tagName;
  final Function() _onPressed;
  final Color _backgroundColor;
  final Icon _icon;

  @override
  Padding build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const NavigatorBeforeButton(),
          FloatingActionButton(
            heroTag: _tagName,
            onPressed: () async {
              await _onPressed();
            },
            backgroundColor: _backgroundColor,
            child: _icon,
          ),
        ],
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
