import 'package:flutter/material.dart';

class CElevatedButton extends StatelessWidget {
  final String bText;
  final bool loading;
  final VoidCallback onPressed;

  const CElevatedButton({
    Key? key,
    required this.bText,
    required this.loading,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: onPressed,
      child: Center(
        child: loading
            ? const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              )
            : Text(
                bText,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
      ),
    );
  }
}

class TElevatedButton extends StatelessWidget {
  final String bText;
  // final bool loading;
  final VoidCallback onPressed;

  const TElevatedButton({
    Key? key,
    required this.bText,
    // required this.loading,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: onPressed,
      child: Center(
        child: Text(
          bText,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
