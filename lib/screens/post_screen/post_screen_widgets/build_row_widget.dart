import 'package:flutter/material.dart';

Container buildRowWidget({
  required String iconName,
  required Widget child,
}) {
  return Container(
    // height: 50,
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: 14,
            backgroundColor: const Color(0xffEBEBEB),
            child: Image.asset(
              iconName,
              color: const Color(0xff1E3C64),
              width: 18,
              height: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: child,
          ),
        ],
      ),
    ),
  );
}

Row buildRow({
  required String iconName,
  required Widget child,
}) {
  return Row(
    children: [
      CircleAvatar(
        maxRadius: 14,
        backgroundColor: Colors.grey[200],
        child: Image.asset(
          iconName,
          width: 18,
          color: const Color(0xff1E3C64),
          height: 18,
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: child,
      ),
    ],
  );
}
