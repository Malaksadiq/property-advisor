import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:property_app/app_widgets/property_item.dart';

class TPropertiesPage extends StatelessWidget {
  final String? propertyType;
  final String? selectedCity;
  final int? selectedbudget;
  final String? pageTitle;
  final String? selectedseller;

  const TPropertiesPage({
    Key? key,
    this.selectedseller,
    this.propertyType,
    this.selectedCity,
    this.selectedbudget,
    required this.pageTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection("propertyDetails");
    if (propertyType != null) {
      query = query.where("propertyType", isEqualTo: propertyType);
    } else if (selectedCity != null) {
      query = query.where("selectedCity", isEqualTo: selectedCity);
    } else if (selectedbudget != null) {
      query = query.where(
        'amount',
        isGreaterThanOrEqualTo: selectedbudget!,
      );
    } else if (selectedseller != null) {
      query = query.where("companyName", isEqualTo: selectedseller);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(pageTitle!),
      ),
      body: StreamBuilder(
        stream: query.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No Data Found in this category"),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var propertyMap = snapshot.data!.docs[index];
              return PropertyItem(
                data: propertyMap,
                pImageUrl: propertyMap['images'][0].toString(),
                pTitle: propertyMap['title'].toString(),
                pLocation: propertyMap['selectedCity'].toString(),
                id: "1",
                pPrice: propertyMap['amount'].toString(),
                baths: propertyMap['bathrooms'].toString(),
                beds: propertyMap['bedroom'].toString(),
              );
            },
          );
        },
      ),
    );
  }
}
