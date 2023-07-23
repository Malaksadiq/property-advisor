import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PropertyCard extends StatelessWidget {
  final String propertyId;
  final String propertyType;
  final String price;
  final String area;
  final String location;
  final String purposeType;

  const PropertyCard({
    super.key,
    required this.propertyId,
    required this.propertyType,
    required this.price,
    required this.area,
    required this.location,
    required this.purposeType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffEBEBEB),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Property ID:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(propertyId.substring(1, 10)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Property Type:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(propertyType),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Price:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  NumberFormat.currency(
                    locale: 'en_PK',
                    symbol: 'PKR ',
                  ).format(int.parse(price)),
                ),
                // Text(price),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Area:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(area),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Location:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(location),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Purpose Type:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(purposeType),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
