import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:property_app/screens/custom_nav_bar/home_screen/tabs/tab_widgets/properties_page.dart';

class SocietiesTab extends StatelessWidget {
  const SocietiesTab({super.key});

  void navigateToSellerProperties(BuildContext context, String selectdSeller) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TPropertiesPage(
          selectedseller: selectdSeller,
          pageTitle: selectdSeller,
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
                      sellerName: propertyMap['companyName'],
                      onTap: () => navigateToSellerProperties(
                          context, propertyMap['companyName']),
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
  final String sellerName;
  final Function onTap;
  const CityItem({
    Key? key,
    required this.sellerName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as VoidCallback?,
      child: Text(
        sellerName,
        style: const TextStyle(
          color: Color.fromARGB(255, 129, 125, 125),
          fontSize: 16,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
