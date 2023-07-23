import 'package:flutter/material.dart';
import 'package:property_app/const/const.dart';

import '../../../../Utils/lists.dart';

class PropertyTypeField extends StatefulWidget {
  final String? selectedType;
  final ValueChanged<String?> onChanged;

  const PropertyTypeField({
    Key? key,
    required this.selectedType,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<PropertyTypeField> createState() => _PropertyTypeFieldState();
}

class _PropertyTypeFieldState extends State<PropertyTypeField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.0,
          ),
        ),
        // suffixText: 'Property Type',
        contentPadding: const EdgeInsets.all(12),
        prefixText: 'Property Type',
        counterText: 'Property Type',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: DropdownButton(
            dropdownColor: const Color(0xffEBEBEB),
            value: widget.selectedType,
            hint: Text(
              widget.selectedType ?? 'select Property Type',
              style: authTextStyle,
            ),
            onChanged: widget.onChanged,
            items: propertyTypes.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(type, style: authTextStyle),
              );
            }).toList(),
            icon: const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(Icons.arrow_drop_down),
            ),
            iconSize: 24,
            isExpanded: true,
            borderRadius: BorderRadius.zero,
            underline: const Divider(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
