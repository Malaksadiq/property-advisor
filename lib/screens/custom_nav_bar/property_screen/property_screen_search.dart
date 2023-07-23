import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:property_app/app_widgets/custom_app_bar.dart';
import 'package:property_app/app_widgets/property_item.dart';

class SearchProperties extends StatelessWidget {
  final String? selectedCity;
  final String? selectedType;
  final double? minPrice;
  final double? maxPrice;

  const SearchProperties({
    Key? key,
    this.maxPrice,
    this.minPrice,
    this.selectedType,
    this.selectedCity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        automaticallyImplyLeadingg: true,
        title: 'Filter Properties',
        toolbarHeight: 50,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("propertyDetails")
            .where("selectedCity", isEqualTo: selectedCity)
            .where('propertyType', isEqualTo: selectedType)
            .where('amount', isGreaterThanOrEqualTo: minPrice)
            .where('amount', isLessThanOrEqualTo: maxPrice)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No Data Found"));
          }

          List<DocumentSnapshot> properties = snapshot.data!.docs;

          return properties.isEmpty
              ? const Center(child: Text('No properties available.'))
              : ListView.builder(
                  itemCount: properties.length,
                  itemBuilder: (context, index) {
                    var propertyMap =
                        properties[index].data() as Map<String, dynamic>;

                    return PropertyItem(
                      data: propertyMap,
                      pImageUrl: propertyMap['images'][0],
                      pTitle: propertyMap['title'],
                      pLocation: propertyMap['selectedCity'],
                      id: "1",
                      pPrice: propertyMap['amount'].toString(),
                      baths: propertyMap['bathrooms'],
                      beds: propertyMap['bedroom'],
                    );
                  },
                );
        },
      ),
    );
  }
}
