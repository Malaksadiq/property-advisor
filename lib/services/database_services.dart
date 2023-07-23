// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class DatabaseServices {
  static Future<void> uploadDataToDatabase({
    required BuildContext context,
    String? uid,
    String? propertyId,
    required String title,
    required String propertyType,
    required String selectedCity,
    required int amount,
    required List<XFile> selectedImages,
    required String bedroom,
    required String bathrooms,
    required String garage,
    required String areaSize,
    required String propertyDescription,
    required List<dynamic> commercialList,
    required List<dynamic> constructionList,
    required List<dynamic> nearByLocationList,
    required List<dynamic> outdoorDetails,
    required String email,
    required String name,
    required String companyName,
    required String phone,
    required String lat,
    required String lang,
    required String purpose,
    required selectedMeasurement,
    required File selectedLogo,
  }) async {
    FirebaseStorage fs = FirebaseStorage.instance;
    String properId = const Uuid().v1();

    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const SpinKitFadingFour(
                color: Colors.grey,
                size: 50.0,
              ),
            ),
          );
        },
        barrierDismissible: false,
      );

      List<String> downloadUrls = [];

      for (var image in selectedImages) {
        Reference ref =
            fs.ref().child('${DateTime.now().millisecondsSinceEpoch}.jpg');
        await ref.putFile(File(image.path));
        String url = await ref.getDownloadURL();
        downloadUrls.add(url);
      }
      FirebaseStorage fStorage = FirebaseStorage.instance;
      Reference ref = fStorage
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString());

      await ref.putFile(File(selectedLogo.path));
      String logoUrl = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection("propertyDetails")
          .doc(properId)
          .set({
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "properId": properId,
        "title": title,
        "propertyType": propertyType,
        "selectedCity": selectedCity,
        "amount": amount,
        "images": downloadUrls,
        "bedroom": bedroom,
        "bathrooms": bathrooms,
        "garage": garage,
        "areaSize": areaSize,
        "propertyDescription": propertyDescription,
        "commercialFeatures": FieldValue.arrayUnion(commercialList),
        "constructionFeatures": FieldValue.arrayUnion(constructionList),
        "nearByLocationFeatures": FieldValue.arrayUnion(nearByLocationList),
        "outdoorFeatures": FieldValue.arrayUnion(outdoorDetails),
        'email': email,
        'phone': phone,
        'sellerName': name,
        'companyName': companyName,
        'latitude': lat,
        'longitude': lang,
        'selectedMeasurement': selectedMeasurement,
        'logo': logoUrl,
        'purPose': purpose,
      });

      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text(
                "There was an error submitting the property details."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}
