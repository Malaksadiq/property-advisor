import 'package:flutter/widgets.dart';

import 'package:property_app/const/const.dart';

// ignore: must_be_immutable
class TextContainer extends StatelessWidget {
  String text;
  TextContainer({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      color: const Color.fromARGB(239, 248, 246, 246),
      // color: Color(0xffFFFFFF),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(text, style: authTextStyle),
        ),
      ),
    );
  }
}
