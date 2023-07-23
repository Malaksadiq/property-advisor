import 'package:flutter/material.dart';

class MyRowWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String labelText;
  final String buttonText;

  const MyRowWidget({
    super.key,
    required this.onPressed,
    required this.labelText,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(labelText),
        Container(
          width: 120,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Theme.of(context).primaryColor),
          ),
          child: MaterialButton(
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
