import 'package:flutter/material.dart';

class CityTypeFeild extends StatefulWidget {
  final String? selectedType;
  final Function? onTap;
  // final ValueChanged<String?> onChange;

  const CityTypeFeild({
    Key? key,
    // required this.onChange,
    required this.onTap,
    required this.selectedType,
  }) : super(key: key);

  @override
  State<CityTypeFeild> createState() => _PropertyTypeFieldState();
}

// final _cityController = TextEditingController();

class _PropertyTypeFieldState extends State<CityTypeFeild> {
  String? _selectedCity;

  @override
  Widget build(BuildContext context) {
    return TextField(
      // onChanged: widget.onChange,
      onTap: () => widget.onTap,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        // prefixText: 'Property Type',
        hintText: _selectedCity ?? 'Select City',

        counterText: 'Select City',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        // suffixIcon: Padding(
        //     padding: const EdgeInsets.only(left: 14.0),
        //     child: IconButton(
        //         onPressed: () => widget.onTap,
        //         icon: const Icon(Icons.arrow_drop_down))),
      ),
    );
  }
}
