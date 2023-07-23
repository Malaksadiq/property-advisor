import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:property_app/app_widgets/custom_app_bar.dart';
import 'package:property_app/const/const.dart';
import 'package:property_app/screens/auth/signup_page.dart';
import 'package:property_app/screens/custom_nav_bar/property_screen/widgets/call_mail_buttons.dart';
import 'package:property_app/screens/custom_nav_bar/property_screen/widgets/call_modal_bottom_sheet.dart';
import 'package:property_app/screens/custom_nav_bar/property_screen/widgets/property_card.dart';
import 'package:url_launcher/url_launcher.dart';

class PropertyDetailScreen extends StatefulWidget {
  static const routName = 'PropertyDetail-Screen';
  final dynamic data;

  // ignore: use_key_in_widget_constructors

  const PropertyDetailScreen({super.key, this.data});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  List favouriteItem = [];

  @override
  void initState() {
    getUserFavourite();
    super.initState();
  }

  getUserFavourite() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      setState(() {
        favouriteItem = snap['favourite'];
      });
    }
  }

  // getUserFavourite() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   setState(() {
  //     favouriteItem = snap['favourite'];
  //   });
  // }

  void showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return CustomBottomSheet(
          contact: widget.data['phone'],
          companyName: widget.data['companyName'],
          selleNama: widget.data['sellerName'],
        );
      },
    );
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

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Add to favorites you have to sign up'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignupPage(),
                  ),
                );
                // Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'No',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  final ScrollController _scrollController = ScrollController();

  void scrollToNextImage() {
    final screenWidth = MediaQuery.of(context).size.width;
    final offset = _scrollController.offset + (screenWidth / 2);
    _scrollController.animateTo(offset,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        appBar: CustomAppBar(
          title: '${widget.data['title']}',
          toolbarHeight: 50,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  widget.data['images'].length,
                  (index) => ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        widget.data['images'][index].toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.data['title'],
                          style: authTextStyle.copyWith(
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.data['selectedCity'],
                              style: authTextStyle),
                          Text(
                            NumberFormat.currency(
                              locale: 'en_PK',
                              symbol: 'PKR ',
                            ).format(
                                int.parse(widget.data['amount'].toString())),
                            style: authTextStyle,
                          ),

                          // Text(widget.data['amount'].toString(),
                          //     style: authTextStyle),
                        ],
                      ),
                    ],
                  ),
                ),
                Text('About this Property',
                    style: authTextStyle.copyWith(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                bDivider,
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildInfoColumn(Icons.garage_sharp, 'garage',
                        "${int.parse(widget.data['garage']) == 0 ? 'N/A' : widget.data['garage']} garage"),
                    buildInfoColumn(Icons.hotel, 'bedroom',
                        "${int.parse(widget.data['bedroom']) == 0 ? 'N/A' : widget.data['bedroom']} Beds"),
                    buildInfoColumn(Icons.bathtub, 'bathrooms',
                        "${int.parse(widget.data['bathrooms']) == 0 ? 'N/A' : widget.data['bathrooms'].toString()} Showers"),
                    buildInfoColumn(
                        Icons.straighten,
                        'areaSize',
                        widget.data['areaSize'] +
                            ' ' +
                            widget.data['selectedMeasurement']),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Property Details',
                  style: authTextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                bDivider,
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PropertyCard(
                    propertyId: widget.data['properId'],
                    propertyType: widget.data['propertyType'],
                    price: widget.data['amount'].toString(),
                    area: widget.data['areaSize'] +
                        ' ' +
                        widget.data['selectedMeasurement'],
                    location: widget.data['selectedCity'],
                    purposeType: widget.data['purPose'],
                  ),
                ),
                Text('Description',
                    style: authTextStyle.copyWith(fontWeight: FontWeight.bold)),
                dDivider,
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(widget.data['propertyDescription'],
                      textAlign: TextAlign.justify, style: authTextStyle),
                ),
                const SizedBox(height: 20),
                dDivider,
                Text('Features',
                    style: authTextStyle.copyWith(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: const Color(0xffEBEBEB),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 6,
                        padding: EdgeInsets.zero,
                        children: [
                          ...[
                            ...widget.data['commercialFeatures'],
                            ...widget.data['constructionFeatures'],
                            ...widget.data['nearByLocationFeatures'],
                            ...widget.data['outdoorFeatures'],
                          ].map<Widget>((feature) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.check_box,
                                    color: Colors.blueGrey,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      feature,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text('Listing Provided by',
                    style: authTextStyle.copyWith(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: const Color(0xffEBEBEB),
                    elevation:
                        4.0, // Adjust the elevation value as per your preference
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30.0,
                            backgroundImage: NetworkImage(
                              widget.data['logo'],
                            ), // Use NetworkImage instead of AssetImage
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/checked.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                    const SizedBox(width: 5.0),
                                    Text(
                                      widget.data['companyName'],
                                      style: const TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  widget.data['sellerName'],
                                  style: const TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            dDivider,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey, width: 1)),
                height: 300,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(double.parse(widget.data['latitude']),
                        double.parse(widget.data['longitude'])),
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('locationMarker'),
                      position: LatLng(double.parse(widget.data['latitude']),
                          double.parse(widget.data['longitude'])),
                    ),
                  },
                ),
              ),
            ),
          ]),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CallMailButton(
                imageAsset: 'assets/images/phone-call.png',
                imageColor: Theme.of(context).primaryColor,
                buttonText: 'Call',
                buttonColor: Theme.of(context).colorScheme.secondary,
                buttonTextColor: Theme.of(context).primaryColor,
                onTap: () {
                  showCustomBottomSheet(context); // Call the function
                },
              ),
              CallMailButton(
                imageAsset: 'assets/images/mail.png',
                imageColor: Colors.black,
                buttonText: 'Mail',
                buttonColor: const Color.fromARGB(255, 214, 214, 214),
                buttonTextColor: Colors.black,
                onTap: () {
                  mail();
                },
              ),
              CallMailButton(
                imageAsset: 'assets/images/whatsapp.png',
                imageColor: Theme.of(context).colorScheme.secondary,
                buttonText: 'WhatsApp',
                buttonColor: Theme.of(context).primaryColor,
                buttonTextColor: Theme.of(context).colorScheme.secondary,
                onTap: () => whatsapp(),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () async {
            var user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              setState(() {
                if (favouriteItem.contains(widget.data['properId'])) {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(user.uid)
                      .update({
                    "favourite":
                        FieldValue.arrayRemove([widget.data['properId']]),
                  });
                } else {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(user.uid)
                      .update({
                    "favourite":
                        FieldValue.arrayUnion([widget.data['properId']]),
                  });
                }
              });
            } else {
              showConfirmationDialog(context);
            }
          },
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseAuth.instance.currentUser != null
                ? FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots()
                : null,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                );
              } else if (snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.data == null) {
                return Icon(
                  Icons.favorite_outline,
                  color: Theme.of(context).colorScheme.secondary,
                );
              } else {
                var userMap = snapshot.data!.data() as Map<String, dynamic>;

                return userMap['favourite'].contains(widget.data['properId'])
                    ? Icon(
                        Icons.favorite,
                        color: Theme.of(context).colorScheme.secondary,
                      )
                    : Icon(
                        Icons.favorite_outline,
                        color: Theme.of(context).colorScheme.secondary,
                      );
              }
            },
          ),
        )

        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: const Color(0xffEC9E37),
        //   child: StreamBuilder(
        //       stream: FirebaseAuth.instance.currentUser != null
        //           ? FirebaseFirestore.instance
        //               .collection("users")
        //               .doc(FirebaseAuth.instance.currentUser!.uid)
        //               .snapshots()
        //           : null,
        //       builder: (context, snapshot) {
        //         if (!snapshot.hasData || snapshot.data == null) {
        //           return const Center(
        //             child: CircularProgressIndicator(),
        //           );
        //         }
        //         var userMap = snapshot.data!.data() as Map<String, dynamic>;

        //         return userMap['favourite'].contains(widget.data['properId'])
        //             ? InkWell(
        //                 onTap: () {
        //                   if (userMap['favourite']
        //                       .contains(widget.data['properId'])) {
        //                     FirebaseFirestore.instance
        //                         .collection("users")
        //                         .doc(FirebaseAuth.instance.currentUser!.uid)
        //                         .update({
        //                       "favourite": FieldValue.arrayRemove(
        //                           [widget.data['properId']]),
        //                     });
        //                   } else {
        //                     FirebaseFirestore.instance
        //                         .collection("users")
        //                         .doc(FirebaseAuth.instance.currentUser!.uid)
        //                         .update({
        //                       "favourite": FieldValue.arrayUnion(
        //                           [widget.data['properId']]),
        //                     });
        //                   }
        //                 },
        //           child: Icon(
        //             Icons.favorite,
        //             color: Theme.of(context).primaryColor,
        //           ),
        //         )
        //       : Icon(
        //           Icons.favorite_outline,
        //           color: Theme.of(context).primaryColor,
        //         );
        // }),
        //   onPressed: () async {
        //     var user = FirebaseAuth.instance.currentUser;
        //     if (user != null) {
        //       setState(() {
        //         if (favouriteItem.contains(widget.data['properId'])) {
        //           FirebaseFirestore.instance
        //               .collection("users")
        //               .doc(user.uid)
        //               .update({
        //             "favourite":
        //                 FieldValue.arrayRemove([widget.data['properId']]),
        //           });
        //         } else {
        //           FirebaseFirestore.instance
        //               .collection("users")
        //               .doc(user.uid)
        //               .update({
        //             "favourite": FieldValue.arrayUnion([widget.data['properId']]),
        //           });
        //         }
        //       });
        //     } else {
        //       // Navigate to sign-up page or display sign-up prompt
        //     }
        //   },

        //   // onPressed: () async {
        //   //   setState(() {
        //   //     if (favouriteItem.contains(widget.data['properId'])) {
        //   //       FirebaseFirestore.instance
        //   //           .collection("users")
        //   //           .doc(FirebaseAuth.instance.currentUser!.uid)
        //   //           .update({
        //   //         "favourite": FieldValue.arrayRemove([widget.data['properId']]),
        //   //       });
        //   //     } else {
        //   //       FirebaseFirestore.instance
        //   //           .collection("users")
        //   //           .doc(FirebaseAuth.instance.currentUser!.uid)
        //   //           .update({
        //   //         "favourite": FieldValue.arrayUnion([widget.data['properId']]),
        //   //       });
        //   //     }
        //   //   });
        //   // },
        // ),
        );
  }
}

Widget buildInfoColumn(IconData icon, String label, String value) {
  return Column(
    children: [
      Icon(
        icon,
        // color: Colors.black54,
        color: const Color(0xff1E3C64),
      ),
      const SizedBox(height: 10),
      Text(
        value,
        style: authTextStyle.copyWith(fontSize: 12),
      ),
    ],
  );
}
//     stream: FirebaseAuth.instance.currentUser != null
// ? FirebaseFirestore.instance
//     .collection("users")
//     .doc(FirebaseAuth.instance.currentUser!.uid)
//     .snapshots()
// : null,
