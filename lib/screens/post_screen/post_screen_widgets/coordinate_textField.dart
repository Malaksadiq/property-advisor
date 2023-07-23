// ignore_for_file: file_names

import 'package:property_app/const/const.dart';

import 'package:flutter/material.dart';

class CoordinateTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final String labelText;

  const CoordinateTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.onChanged,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: authTextStyle,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.0,
          ),
        ),
      ),
    ));
  }
}
