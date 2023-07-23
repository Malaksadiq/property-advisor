// ignore_for_file: library_private_types_in_public_api, unused_element, avoid_print, unused_field

import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:property_app/Utils/lists.dart';
import 'package:property_app/const/const.dart';

class FeaturePage extends StatefulWidget {
  const FeaturePage({super.key});

  @override
  _FeaturePageState createState() => _FeaturePageState();
}

class _FeaturePageState extends State<FeaturePage> {
  final bool _isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Amenities and Features Title

              // Commercial Features Title
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 16),
                child: Text(
                  'Commercial Features',
                  style: authTextStyle.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              // Commercial Features Checkboxes
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: commercialFeatures.length,
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(
                    title: Text(
                      commercialFeatures[index]['title'],
                      style: authTextStyle,
                    ),
                    value: commercialFeatures[index]['value'],
                    onChanged: (value) {
                      setState(() {
                        commercialFeatures[index]['value'] = value;
                      });
                    },
                  );
                },
              ),
              // Construction Features Title
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
                child: Text('Construction Features',
                    style: authTextStyle.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              // Construction Features Checkboxes
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
                      fontWeight: FontWeight.bold, color: Colors.black),
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
                      });
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
                child: Text(' Outdoor Details',
                    style: authTextStyle.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black)),
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
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
