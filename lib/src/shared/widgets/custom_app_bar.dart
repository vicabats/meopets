import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          title: Image.asset(
            'assets/icons/logo.png',
            height: kBottomNavigationBarHeight,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
