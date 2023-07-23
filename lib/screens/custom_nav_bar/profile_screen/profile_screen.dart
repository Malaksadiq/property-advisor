import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:property_app/Screens/custom_nav_bar/nav_bar_screen.dart';
import 'package:property_app/app_widgets/app_drawer.dart';
import 'package:property_app/app_widgets/custom_app_bar.dart';
import 'package:property_app/screens/auth/signup_page.dart';
import 'package:property_app/screens/custom_nav_bar/profile_screen/my_properties_screen.dart';
import 'package:property_app/screens/custom_nav_bar/profile_screen/setting_screen.dart';
import 'package:property_app/screens/settings/contact_us_screen.dart';
import 'package:property_app/screens/settings/term_policy.dart';

import 'profile_widgets/profile_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = '';
  String email = '';
  String userType = '';

  @override
  void initState() {
    super.initState();
    getUserNameAndEmail();
  }

  getUserNameAndEmail() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      if (snap.exists) {
        setState(() {
          username = snap.get('username') ?? '';
          email = snap.get('email') ?? '';
          userType = snap.get('userType') ?? '';
        });
      }
    }
  }

  // @override
  // void initState() {
  //   getUserNameAndEmail();
  //   super.initState();
  // }

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      appBar: const CustomAppBar(
        automaticallyImplyLeadingg: true,
        title: 'Profile',
        toolbarHeight: 50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            email.isEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Login', style: TextStyle(fontSize: 18)),
                          const SizedBox(height: 4),
                          InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupPage()));
                              },
                              child: Text(
                                'Log in to your Account',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18),
                              )),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupPage()));
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: const Color(0xffEBEBEB),
                              borderRadius: BorderRadius.circular(14)),
                          child: Icon(
                            Icons.person_2_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: const Color(0xffEBEBEB),
                              // backgroundImage: const AssetImage('assets/profile_picture.jpg'),
                              child: username.isNotEmpty
                                  ? Text(
                                      username.isNotEmpty
                                          ? username
                                              .substring(0, 1)
                                              .toUpperCase()
                                          : '',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Icon(
                                      Icons.person_2_outlined,
                                      color: Theme.of(context).primaryColor,
                                    ),
                            ),
                            const SizedBox(height: 16),
                            username.isNotEmpty
                                ? Text(
                                    username.isNotEmpty
                                        ? '${username[0].toUpperCase()}${username.substring(1)}'
                                        : '',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  )
                                : const Text('User Name'),
                          ],
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 1.2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ProfileCard(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsPage()));
                            },
                            icon: Image.asset(
                              'assets/images/settings.png',
                              width: 34,
                              height: 34,
                              color: const Color(0xffEC9E37),
                            ),
                            title: 'Profile Settings',
                          ),
                          if (userType == 'buyer' || userType.isEmpty)
                            ProfileCard(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BNavigationBar(3)));
                              },
                              icon: Image.asset(
                                'assets/images/heart.png',
                                width: 34,
                                height: 34,
                                color: const Color(0xffEC9E37),
                              ),
                              title: 'My Favourits',
                            ),
                          if (userType == 'seller')
                            ProfileCard(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BNavigationBar(2)));
                              },
                              icon: Image.asset(
                                'assets/images/heart.png',
                                width: 34,
                                height: 34,
                                color: const Color(0xffEC9E37),
                              ),
                              title: 'My Favourits',
                            ),
                          if (userType == 'seller')
                            ProfileCard(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyProperties(
                                              currentIndex: 0,
                                            )));
                              },
                              icon: Image.asset(
                                'assets/images/real-state.png',
                                width: 34,
                                height: 34,
                                color: const Color(0xffEC9E37),
                              ),
                              title: 'My Properties',
                            ),
                          if (userType == 'buyer')
                            ProfileCard(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BNavigationBar(1)));
                              },
                              icon: Image.asset(
                                'assets/images/real-state.png',
                                width: 34,
                                height: 34,
                                color: const Color(0xffEC9E37),
                              ),
                              title: 'Properties',
                            ),
                        ],
                      ),
                    ],
                  ),
            const SizedBox(height: 30),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: ListTile(
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                    ),
                    leading: Image.asset(
                      'assets/images/contact-book.png',
                      width: 25,
                      height: 25,
                    ),
                    title: const Text(
                      'Contact Us',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContactUScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: ListTile(
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                    ),
                    leading: Image.asset(
                      'assets/images/terms.png',
                      width: 25,
                      height: 25,
                    ),
                    title: const Text(
                      'Term and Policies',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TermPolicies()),
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
