import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {
  isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(const Duration(seconds: 4), () {
        Navigator.pushReplacementNamed(context, 'BNavigationBar');
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const SplashPage()));
      });
    } else {
      Timer(const Duration(seconds: 4), () {
        Navigator.pushReplacementNamed(context, 'BNavigationBar');
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => SplashPage()));
      });
      // }
    }
  }
}
