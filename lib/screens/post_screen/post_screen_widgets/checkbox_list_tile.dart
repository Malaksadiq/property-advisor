// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class KCheckboxListTile extends StatefulWidget {
  bool value;
  final String title;
  KCheckboxListTile({
    super.key,
    required this.value,
    required this.title,
  });

  @override
  State<KCheckboxListTile> createState() => _KCheckboxListTileState();
}

class _KCheckboxListTileState extends State<KCheckboxListTile> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.title),
      value: widget.value,
      onChanged: (value) {
        setState(() {
          widget.value = value!;
        });
      },
    );
  }
}
