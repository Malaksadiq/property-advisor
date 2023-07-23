import 'package:flutter/material.dart';
import 'package:property_app/app_widgets/custom_app_bar.dart';
import 'package:property_app/const/const.dart';
import 'package:property_app/screens/auth/auth_widgets/auth_custom_button.dart';

import 'package:property_app/screens/custom_nav_bar/property_screen/property_screen_search.dart';
import 'package:property_app/screens/post_screen/post_screen_widgets/cityyyyyyyy.dart';

import 'search_screen_widgets/area_price_type_feild.dart';
import 'search_screen_widgets/property_type_feild.dart';

class SearchScreen extends StatefulWidget {
  final String? selectedCityyy;
  const SearchScreen({
    Key? key,
    this.selectedCityyy,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? _selectedCity;

  void _showCitySelectionModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (ctx) {
        return Cityy(
          onCitySelected: (selectedCity) {
            setState(() {
              _selectedCity = selectedCity.toString();
            });
          },
          selectedCity: _selectedCity, // Pass the selected city to the modal
        );
      },
    );
  }

  String? selectedType;
  double? minimumPrice;
  double? maximumPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        automaticallyImplyLeadingg: true,
        title: 'Filter',
        toolbarHeight: 50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PropertyTypeField(
              selectedType: selectedType,
              onChanged: (newValue) {
                setState(() {
                  selectedType = newValue;
                });
              },
            ),
            //PropertyTypeField End
            const SizedBox(height: 10),
            TextField(
              onTap: () {
                _showCitySelectionModal(context);
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1.0,
                  ),
                ),
                contentPadding: const EdgeInsets.all(12),
                hintText:
                    _selectedCity ?? widget.selectedCityyy ?? 'Select City',
                hintStyle: authTextStyle,
                counterText: 'All Cities',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: IconButton(
                        onPressed: () {
                          _showCitySelectionModal(context);
                        },
                        icon: const Icon(Icons.arrow_drop_down))),
              ),
            ),
            const Text('Price Rang (PKR)', style: authTextStyle),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AreaPriceTextField(
                  labelText: 'Minimum',
                  onChanged: (value) {
                    setState(() {
                      minimumPrice = value;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'to',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                AreaPriceTextField(
                  labelText: 'Maximum',
                  onChanged: (value) {
                    setState(() {
                      maximumPrice = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 45,
              child: CElevatedButton(
                loading: false,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchProperties(
                        selectedCity: _selectedCity,
                        selectedType: selectedType,
                        maxPrice: maximumPrice,
                        minPrice: minimumPrice,
                      ),
                    ),
                  );
                },
                bText: 'Let\'s Find',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
