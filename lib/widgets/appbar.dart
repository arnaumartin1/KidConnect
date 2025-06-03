import 'package:flutter/material.dart';

class KidConnectAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KidConnectAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('KidConnect'),
      centerTitle: true,
      backgroundColor: const Color(0xFF6B8C89), // Optional custom color
      elevation: 2,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
