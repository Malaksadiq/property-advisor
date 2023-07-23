// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CircleAvatarWrap extends StatelessWidget {
  final int itemCount;
  final Function(int) onTap;
  final int selectedValue;

  const CircleAvatarWrap({
    Key? key,
    required this.itemCount,
    required this.onTap,
    required this.selectedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
        itemCount,
        (index) => GestureDetector(
          onTap: () {
            onTap(index);
          },
          child: CircleAvatar(
            radius: 15,
            backgroundColor: selectedValue == index
                ? Theme.of(context).primaryColor
                : Colors.grey[200],
            child: Text(
              '$index',
              style: TextStyle(
                fontSize: 12,
                color: selectedValue == index ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
