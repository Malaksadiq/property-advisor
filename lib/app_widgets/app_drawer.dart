import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:property_app/Utils/utils.dart';

import '../Screens/custom_nav_bar/nav_bar_screen.dart';
import '../Screens/settings/contact_us_screen.dart';
import '../Screens/settings/term_policy.dart';
import '../screens/auth/login_page.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String username = '';
  String email = '';
  String userType = '';

  getUserNameAndEmail() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      setState(() {
        username = snap['username'];
        email = snap['email'];
        userType = snap['userType'];
      });
    } else {
      return null;
      // Handle the case when the user is not logged in
    }
  }

  @override
  void initState() {
    getUserNameAndEmail();
    super.initState();
  }

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xffEBEBEB), // shape: DrawerThemeData,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage(
                        'assets/images/1.png',
                      ),
                      height: 60,
                      width: 60,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Property Advisor',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                username.isNotEmpty
                    ? Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffEBEBEB),
                              ),
                              child: Center(
                                child: Text(
                                  username.isNotEmpty
                                      ? '${username[0].toUpperCase()}${username.substring(1)}'
                                      : '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text(
                                'Log'
                                'in or create Account',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              Icon(Icons.arrow_forward)
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
          if (userType == 'buyer')
            ListTile(
              leading: Image.asset(
                'assets/images/home (1).png',
                width: 25,
                height: 25,
              ),
              title: const Text('Home'),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BNavigationBar(0)));
              },
            ),
          if (userType == 'seller')
            ListTile(
              leading: Image.asset(
                'assets/images/house.png',
                width: 25,
                height: 25,
              ),
              title: const Text('Add Property'),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BNavigationBar(0)));
              },
            ),
          ListTile(
            leading: Image.asset(
              'assets/images/real-state.png',
              width: 25,
              height: 25,
            ),
            title: userType == 'buyer' || userType.isEmpty
                ? const Text('Properties')
                : const Text('My Properties'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BNavigationBar(1)));
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/contact-book.png',
              width: 25,
              height: 25,
            ),
            title: const Text('Contact Us'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContactUScreen()));
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/terms.png',
              width: 25,
              height: 25,
            ),
            title: const Text('Term and Policies'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TermPolicies()));
            },
          ),
          if (username.isNotEmpty)
            ListTile(
              leading: Image.asset(
                'assets/images/log-out.png',
                width: 25,
                height: 25,
              ),
              title: const Text('LogOut'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirmation'),
                      content: const Text('Are you sure you want to log out?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Perform the logout action here
                            auth.signOut().then((value) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              ).onError((error, stackTrace) {
                                Utils().toastMessage(error.toString());
                              });
                            });

                            Navigator.pop(context); // Close the dialog
                          },
                          child: Text(
                            'Yes',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          child: Text(
                            'No',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            )
        ],
      ),
    );
  }
}
