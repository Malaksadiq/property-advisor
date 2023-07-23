// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:property_app/Utils/lists.dart';
import 'package:property_app/app_widgets/custom_app_bar.dart';
import 'package:property_app/const/const.dart';
import 'package:property_app/screens/auth/auth_widgets/auth_custom_button.dart';

class AmenitiesAndFeaturesScreen extends StatefulWidget {
  final List<String> commercialFeatures;
  final List<String> constructionFeatures;
  final List<String> nearbyLocationFeatures;
  final List<String> outdoorFeatures;

  const AmenitiesAndFeaturesScreen({
    super.key,
    required this.commercialFeatures,
    required this.constructionFeatures,
    required this.nearbyLocationFeatures,
    required this.outdoorFeatures,
  });

  @override
  _AmenitiesAndFeaturesScreenState createState() =>
      _AmenitiesAndFeaturesScreenState();
}

class _AmenitiesAndFeaturesScreenState
    extends State<AmenitiesAndFeaturesScreen> {
  final List<String> _selectedCommercialFeatures = [];
  final List<String> _selectedConstructionFeatures = [];
  final List<String> _selectedNearbyLocationFeatures = [];
  final List<String> _selectedOutdoorFeatures = [];

  @override
  void initState() {
    _selectedCommercialFeatures.addAll(widget.commercialFeatures);
    _selectedConstructionFeatures.addAll(widget.constructionFeatures);
    _selectedNearbyLocationFeatures.addAll(widget.nearbyLocationFeatures);
    _selectedOutdoorFeatures.addAll(widget.outdoorFeatures);
    super.initState();
  }

  void _updateFeatures() {
    final updatedFeatures = {
      'commercial': _selectedCommercialFeatures,
      'construction': _selectedConstructionFeatures,
      'nearby': _selectedNearbyLocationFeatures,
      'outdoor': _selectedOutdoorFeatures,
    };

    Navigator.pop(context, updatedFeatures);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        automaticallyImplyLeadingg: true,
        title: 'Select Amenities and Features',
        toolbarHeight: 50,
      ),
      // appBar: AppBar(
      //   title: const Text('Amenities and Features'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18, left: 16),
              child: Text(
                'Commercial Features',
                style: authTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: commercialFeatures.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: CheckboxListTile(
                    title: Text(
                      commercialFeatures[index]['title'],
                      style: authTextStyle,
                    ),
                    value: commercialFeatures[index]['value'],
                    onChanged: (value) {
                      setState(() {
                        commercialFeatures[index]['value'] = value;
                        if (value!) {
                          _selectedCommercialFeatures
                              .add(commercialFeatures[index]['title']);
                        } else {
                          _selectedCommercialFeatures
                              .remove(commercialFeatures[index]['title']);
                        }
                      });
                    },
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Text(
                'Construction Features',
                style: authTextStyle.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: constructionFeatures.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  title: Text(
                    constructionFeatures[index]['title'],
                    style: authTextStyle,
                  ),
                  value: constructionFeatures[index]['value'],
                  onChanged: (value) {
                    setState(() {
                      constructionFeatures[index]['value'] = value;
                      if (value!) {
                        _selectedConstructionFeatures
                            .add(constructionFeatures[index]['title']);
                      } else {
                        _selectedConstructionFeatures
                            .remove(constructionFeatures[index]['title']);
                      }
                    });
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Text(
                'Nearby Locations and Facilities',
                style: authTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: nearbyLocations.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  title: Text(
                    nearbyLocations[index]['title'],
                    style: authTextStyle,
                  ),
                  value: nearbyLocations[index]['value'],
                  onChanged: (value) {
                    setState(() {
                      nearbyLocations[index]['value'] = value;
                      if (value!) {
                        _selectedNearbyLocationFeatures
                            .add(nearbyLocations[index]['title']);
                      } else {
                        _selectedNearbyLocationFeatures
                            .remove(nearbyLocations[index]['title']);
                      }
                    });
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Text(
                'Outdoor Details',
                style: authTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: outdoorDetails.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  title: Text(
                    outdoorDetails[index]['title'],
                    style: authTextStyle,
                  ),
                  value: outdoorDetails[index]['value'],
                  onChanged: (value) {
                    setState(() {
                      outdoorDetails[index]['value'] = value;
                      if (value!) {
                        _selectedOutdoorFeatures
                            .add(outdoorDetails[index]['title']);
                      } else {
                        _selectedOutdoorFeatures
                            .remove(outdoorDetails[index]['title']);
                      }
                    });
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 45,
                child: CElevatedButton(
                  bText: 'Save',
                  loading: false,
                  onPressed: _updateFeatures,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
