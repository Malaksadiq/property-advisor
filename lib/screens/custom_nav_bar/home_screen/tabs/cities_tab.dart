import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:property_app/screens/custom_nav_bar/home_screen/tabs/tab_widgets/properties_page.dart';

class CitiesTab extends StatelessWidget {
  const CitiesTab({super.key});

  void navigateToCityProperties(BuildContext context, String selectedCity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TPropertiesPage(
          selectedCity: selectedCity,
          pageTitle: selectedCity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("propertyDetails")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final propertyDocs = snapshot.data!.docs;
            final itemCount = propertyDocs.length;

            return GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 0.0,
                childAspectRatio: 0.50,
                mainAxisSpacing: 10.0,
              ),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                var propertyMap = propertyDocs[index];
                return Column(
                  children: [
                    CityItem(
                      cityName: propertyMap['selectedCity'],
                      onTap: () => navigateToCityProperties(
                          context, propertyMap['selectedCity']),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CityItem extends StatelessWidget {
  final String cityName;
  final Function onTap;
  const CityItem({
    Key? key,
    required this.cityName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as VoidCallback?,
      child: Text(
        cityName,
        style: const TextStyle(
          color: Color.fromARGB(255, 129, 125, 125),
          fontSize: 16,
        ),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
      ),
    );
  }
}
