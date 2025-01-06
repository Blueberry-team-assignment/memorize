import 'package:flutter/material.dart';

class MemorizedAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MemorizedAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Memorize'),
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
