import 'package:flutter/material.dart';
import 'package:property_app/const/const.dart';

class UploadScreenTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String iconName;
  const UploadScreenTextInput(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.iconName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
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
                color: Theme.of(context).primaryColor,
                width: 18,
                height: 18,
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: TextFormField(
                style: authTextStyle,
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: authTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
