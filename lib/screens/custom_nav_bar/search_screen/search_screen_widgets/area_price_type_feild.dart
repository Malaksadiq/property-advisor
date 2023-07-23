import 'package:flutter/material.dart';
import 'package:property_app/const/const.dart';

class AreaPriceTextField extends StatelessWidget {
  final String labelText;
  final ValueChanged<double> onChanged;

  const AreaPriceTextField({
    super.key,
    required this.labelText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        style: authTextStyle,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          final double? parsedValue = double.tryParse(value);
          if (parsedValue != null) {
            onChanged(parsedValue);
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          labelText: labelText,
          labelStyle: authTextStyle.copyWith(fontSize: 12),
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
      ),
    );
  }
}
