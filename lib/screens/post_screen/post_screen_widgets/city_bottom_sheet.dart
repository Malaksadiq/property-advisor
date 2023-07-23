// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:property_app/const/const.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CitySelectionModal extends StatefulWidget {
  final void Function(String? selectedCity) onCitySelected;
  final String? selectedCity;

  const CitySelectionModal({
    Key? key,
    required this.onCitySelected,
    this.selectedCity,
  }) : super(key: key);

  @override
  _CitySelectionModalState createState() => _CitySelectionModalState();
}

class _CitySelectionModalState extends State<CitySelectionModal> {
  final TextEditingController _searchController = TextEditingController();

  String? _selectedCity;
  List<String> _filteredCities = [];

  @override
  void initState() {
    super.initState();
    _selectedCity = widget.selectedCity; // Set the initially selected city
    fetchAllCities();
  }

  Future<void> fetchAllCities() async {
    try {
      final cities = await fetchCities('');
      setState(() {
        _filteredCities = cities;
      });
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      // Handle the error, e.g., display an error message
    }
  }

  Future<List<String>> fetchCities(String query) async {
    const apiKey =
        'AIzaSyC2rmv_2WJ3EPGXu58tm4O1thTDEn0YVak'; // Replace with your actual API key
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&types=(cities)&components=country:pk&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      final predictions = responseData['predictions'] as List<dynamic>;
      final cities = predictions
          .map((prediction) => prediction['description'])
          .toList()
          .cast<String>();
      return cities;
    } else {
      throw Exception('Failed to fetch cities');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: const Text(
            'Select City',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: _selectedCity == null
              ? null
              : Text(
            'Current City: $_selectedCity',
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          child: TypeAheadField<String>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _searchController,
              style: authTextStyle,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.black),
                ),
                contentPadding: const EdgeInsets.all(8),
                hintText: 'Search for Cities',
                hintStyle: authTextStyle,
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            suggestionsCallback: (pattern) async {
              return await fetchCities(pattern);
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(
                  suggestion,
                  style: authTextStyle,
                ),
              );
            },
            onSuggestionSelected: (suggestion) {
              setState(() {
                _selectedCity = suggestion;
              });
              Navigator.pop(context);
              widget.onCitySelected(_selectedCity);
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _filteredCities.length,
            itemBuilder: (ctx, index) {
              return ListTile(
                title: Text(
                  _filteredCities[index],
                  style: authTextStyle,
                ),
                onTap: () {
                  setState(() {
                    _selectedCity = _filteredCities[index];
                  });
                  Navigator.pop(context);
                  widget.onCitySelected(_selectedCity);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}


// ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:property_app/Utils/lists.dart';
// import 'package:property_app/const/const.dart';

// class CitySelectionModal extends StatefulWidget {
//   final void Function(String? selectedCity) onCitySelected;
//   final String? selectedCity;

//   const CitySelectionModal(
//       {super.key, required this.onCitySelected, this.selectedCity});

//   @override
//   _CitySelectionModalState createState() => _CitySelectionModalState();
// }

// class _CitySelectionModalState extends State<CitySelectionModal> {
//   final TextEditingController _searchController = TextEditingController();
//   String? _selectedCity;
//   List<String> _filteredCities = kpkCities;

//   @override
//   void initState() {
//     super.initState();
//     _selectedCity = widget.selectedCity; // Set the initially selected city
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         ListTile(
//           title: const Text(
//             'Select City',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),
//           subtitle: _selectedCity == null
//               ? null
//               : Text(
//                   'Current City: $_selectedCity',
//                   style: authTextStyle.copyWith(
//                       fontSize: 14, fontWeight: FontWeight.bold),
//                 ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
//           child: TextField(
//             controller: _searchController,
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.all(8),
//               hintText: 'Search for Cities',
//               hintStyle: authTextStyle,
//               prefixIcon: const Icon(Icons.search),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(5),
//                 borderSide: const BorderSide(color: Colors.grey),
//               ),
//             ),
//             onChanged: (value) {
//               // Filter the cities based on the search text
//               setState(() {
//                 _filteredCities = kpkCities
//                     .where((city) =>
//                         city.toLowerCase().contains(value.toLowerCase()))
//                     .toList();
//               });
//             },
//           ),
//         ),
//         Expanded(
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: _filteredCities.length,
//             itemBuilder: (ctx, index) {
//               return ListTile(
//                 title: Text(
//                   _filteredCities[index],
//                   style: authTextStyle,
//                 ),
//                 onTap: () {
//                   setState(() {
//                     _selectedCity = _filteredCities[index];
//                   });
//                   Navigator.pop(context);
//                   widget.onCitySelected(_selectedCity);
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
