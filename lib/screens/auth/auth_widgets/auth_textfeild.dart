import 'package:flutter/material.dart';
import 'package:property_app/const/const.dart';

class AuthCustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const AuthCustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: authTextStyle,
      controller: controller,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        fillColor: Colors.white,
        filled: true,
        hintStyle: const TextStyle(
          color: Color.fromARGB(255, 102, 96, 96),
          fontWeight: FontWeight.normal,
        ),
        labelStyle: const TextStyle(
            color: Color.fromARGB(255, 102, 96, 96),
            fontWeight: FontWeight.normal,
            fontSize: 14),
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.0,
          ),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
