import 'package:flutter/material.dart';

class CallMailButton extends StatelessWidget {
  final String imageAsset;
  final Color imageColor;
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final Function() onTap;

  const CallMailButton({
    super.key,
    required this.imageAsset,
    required this.imageColor,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
          ),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imageAsset,
                color: imageColor,
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
              Text(
                buttonText,
                style: TextStyle(
                  color: buttonTextColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
