// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:property_app/const/const.dart';
import 'package:property_app/screens/auth/auth_widgets/auth_custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomBottomSheet extends StatefulWidget {
  final String contact;
  final String selleNama;
  final String companyName;

  const CustomBottomSheet(
      {super.key,
      required this.contact,
      required this.companyName,
      required this.selleNama});

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  void call() async {
    var androidCallUrl = "tel:${widget.contact}";
    var iosUrl = "https://wa.me/${widget.contact}?text=${Uri.parse('Hi')}";

    try {
      if (Platform.isAndroid) {
        await launchUrl(Uri.parse(androidCallUrl));
      } else if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      }
    } on Exception {
      if (kDebugMode) {
        print('Failed to launch WhatsApp or make a call.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Padding(
          padding:
              const EdgeInsets.only(bottom: 16, top: 8, left: 12, right: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Call Seller',
                      style: authTextStyle,
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              bDivider,
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Contact Person',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.selleNama,
                        ),
                        Text(
                          widget.companyName,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              bDivider,
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Call'),
                            Text(widget.contact),
                          ],
                        ),
                      ],
                    ),
                    CElevatedButton(
                      bText: 'Call',
                      loading: false,
                      onPressed: () {
                        call();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}



// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:property_app/const/const.dart';
// import 'package:property_app/screens/auth/auth_widgets/auth_custom_button.dart';
// import 'package:url_launcher/url_launcher.dart';

// void callShowModalBottomSheet(BuildContext context) {
//   call() async {
//     var contact = "+923427877112";

//     var androidCallUrl = "tel:$contact";
//     var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi')}";

//     try {
//       if (Platform.isAndroid) {
//         await launchUrl(Uri.parse(androidCallUrl));
//       } else if (Platform.isIOS) {
//         await launchUrl(Uri.parse(iosUrl));
//       }
//     } on Exception {
//       if (kDebugMode) {
//         print('Failed to launch WhatsApp or make a call.');
//       }
//     }
//   }

//   showModalBottomSheet(
//     shape: const OutlineInputBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(14),
//         topRight: Radius.circular(14),
//       ),
//     ),
//     backgroundColor: Colors.white,
//     context: context,
//     builder: (BuildContext context) {
//       return Padding(
//         padding: const EdgeInsets.only(bottom: 16, top: 8, left: 12, right: 12),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Call Seller',
//                     style: authTextStyle,
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.clear),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             bDivider,
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//               child: Row(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     padding: const EdgeInsets.all(8.0),
//                     child: const Icon(
//                       Icons.person,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   const Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Contact Person',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'Musa Khan',
//                       ),
//                       Text(
//                         'Al Majid',
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             bDivider,
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey,
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         padding: const EdgeInsets.all(8.0),
//                         child: const Icon(
//                           Icons.call,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       const Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Call'),
//                           Text('03427877112'),
//                         ],
//                       ),
//                     ],
//                   ),
//                   CElevatedButton(
//                     bText: 'Call',
//                     loading: false,
//                     onPressed: () {
//                       call();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
