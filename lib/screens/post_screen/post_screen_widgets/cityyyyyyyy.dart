// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class Cityy extends StatefulWidget {
  final void Function(String? selectedCity) onCitySelected;
  final String? selectedCity;

  const Cityy({
    Key? key,
    required this.onCitySelected,
    this.selectedCity,
  }) : super(key: key);

  @override
  _CitySelectionModalState createState() => _CitySelectionModalState();
}

class _CitySelectionModalState extends State<Cityy> {
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
      final cities = await fetchCities();
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

  Future<List<String>> fetchCities() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('propertyDetails')
        .orderBy('selectedCity')
        .get();

    final cities = snapshot.docs
        .map((doc) => doc['selectedCity'] as String)
        .toList()
        .cast<String>();

    return cities;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          child: TypeAheadField<String>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _searchController,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                contentPadding: const EdgeInsets.all(8),
                hintText: 'Search for Cities',
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
              return await fetchCities();
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(
                  suggestion,
                  style: const TextStyle(fontSize: 16),
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
                  style: const TextStyle(fontSize: 16),
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
