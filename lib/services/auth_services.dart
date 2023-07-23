// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

enum UserType {
  buyer,
  seller,
}

class AuthServices {
  static void signUp({
    BuildContext? context,
    String? username,
    String? email,
    String? pass,
    UserType userType = UserType.buyer,
  }) async {
    try {
      EasyLoading.show(status: "Please Wait");
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: pass!,
      );
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "email": email,
        "username": username,
        "favourite": [],
        "userType": userType == UserType.seller ? "seller" : "buyer",
      });
      EasyLoading.dismiss();
      EasyLoading.showInfo("Successfully Registered. Log in Now");
      final String uid = FirebaseAuth.instance.currentUser!.uid;
      final DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final String userTypeStr = userSnapshot.get('userType');
      if (userType == UserType.seller && userTypeStr == 'seller') {
        Navigator.of(context!).pushReplacementNamed('BNavigationBar');
      } else {
        Navigator.of(context!).pushReplacementNamed('BNavigationBar');
      }
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError(e.message.toString());
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(e.message.toString());
      }
    }
  }

  static signIn({
    BuildContext? context,
    String? email,
    String? pass,
    UserType userType = UserType.buyer,
  }) async {
    try {
      EasyLoading.show(
        status: "Please Wait",
      );
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: pass!,
      );

      final String uid = FirebaseAuth.instance.currentUser!.uid;

      // Retrieve the user type from Firestore based on the user's UID
      final DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final String userTypeStr = userSnapshot.get('userType');

      EasyLoading.dismiss();
      if (userType == UserType.seller && userTypeStr == 'seller') {
        Navigator.of(context!).pushReplacementNamed('BNavigationBar');
      } else {
        Navigator.of(context!).pushReplacementNamed('BNavigationBar');
      }
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError(e.message.toString());
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(e.message.toString());
      }
    }
  }
}
