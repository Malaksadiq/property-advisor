import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../const/const.dart';
import '../screens/custom_nav_bar/property_screen/property_detail_screen.dart';

/// A widget that represents a single property item.
class PropertyItem extends StatefulWidget {
  final String pImageUrl;
  final String pTitle;
  final String pLocation;
  final String id;
  final String pPrice;
  final String baths;
  final String beds;
  final dynamic data;

  // bool isFavorite;
  final List<PropertyItem>? propertyItems;

  const PropertyItem({
    this.propertyItems,
    Key? key,
    required this.pImageUrl,
    required this.pTitle,
    required this.pLocation,
    required this.id,
    required this.pPrice,
    required this.baths,
    required this.beds,
    this.data,
  }) : super(key: key);

  @override
  State<PropertyItem> createState() => _PropertyItemState();
}

class _PropertyItemState extends State<PropertyItem> {
  bool isFavorite = false;

  //whatsapp
  whatsapp() async {
    // var contact = "+923427877112";
    var contact = widget.data['phone'];
    var androidUrl = "whatsapp://send?phone=$contact&text=Hi How are you";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi How are you')}";

    try {
      if (Platform.isAndroid) {
        await launchUrl(Uri.parse(androidUrl));
      } else {
        await launchUrl(Uri.parse(iosUrl));
      }
    } on Exception {
      const Text('WhatsApp is not installed.');
    }
  }

  mail() async {
    var email = widget.data['email'];
    var iosMailUrl = "mailto:$email";

    try {
      if (Platform.isAndroid) {
        await launchUrl(Uri.parse(iosMailUrl));
      } else if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosMailUrl));
      }
    } on Exception {
      if (kDebugMode) {
        print('Failed to launch WhatsApp or make a call.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PropertyDetailScreen(data: widget.data),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          elevation: 4,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Displays the property image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.pImageUrl,
                    height: 110,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Displays the property title
                      Text(
                        widget.pTitle,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: mediaQuery.size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Displays the property location
                      Text(
                        widget.pLocation,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: mediaQuery.size.width * 0.04,
                        ),
                      ),
                      // Displays the number of bedrooms and bathrooms

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.bed, size: 18),
                              const SizedBox(width: 5),
                              int.tryParse(widget.beds) == 0
                                  ? const Text(
                                      'N/A',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  : Text(
                                      widget.beds.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              const SizedBox(width: 10),
                              const Icon(Icons.bathtub, size: 18),
                              const SizedBox(width: 5),
                              int.tryParse(widget.beds) == 0
                                  ? const Text(
                                      'N/A',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  : Text(
                                      widget.baths.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ],
                          ),
                          // Displays icons for email and whatsapp
                          Row(
                            children: [
                              // Icon(Icons.mail),
                              IconButton(
                                  onPressed: () {
                                    mail();
                                  },
                                  icon: const Icon(Icons.mail)),
                              IconButton(
                                onPressed: () {
                                  whatsapp();
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Displays the property price
                      Text(
                        NumberFormat.currency(
                          locale: 'en_PK',
                          symbol: 'PKR ',
                        ).format(int.parse(
                          widget.data['amount'].toString().replaceAll(
                              RegExp(r'[^0-9]'),
                              ''), // Extract numeric part by removing non-numeric characters
                        )),
                        style: authTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
