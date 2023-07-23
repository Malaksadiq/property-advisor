import 'package:flutter/material.dart';

class TermPolicies extends StatelessWidget {
  const TermPolicies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text('Term and Policies '),
      ),
    );
  }
}
