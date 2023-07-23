import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double toolbarHeight;
  final bool? automaticallyImplyLeadingg;

  const CustomAppBar(
      {super.key,
      required this.title,
      required this.toolbarHeight,
      this.automaticallyImplyLeadingg});

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeadingg ?? true,
      toolbarHeight: toolbarHeight,
      backgroundColor: Theme.of(context).primaryColor,
      iconTheme: const IconThemeData(
        size: 22,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
      ),
    );
  }
}
