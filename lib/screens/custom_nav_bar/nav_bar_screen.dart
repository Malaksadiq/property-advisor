// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:property_app/Screens/custom_nav_bar/profile_screen/profile_screen.dart';
import 'package:property_app/Screens/custom_nav_bar/property_screen/properties_screen.dart';
import 'package:property_app/screens/custom_nav_bar/home_screen/home_screen.dart';
import 'package:property_app/screens/custom_nav_bar/search_screen/search_screen.dart';
import 'package:property_app/screens/post_screen/upload_data_screen.dart';

import 'favorite_screen.dart';

class BNavigationBar extends StatefulWidget {
  int currentIndex;
  BNavigationBar(this.currentIndex, {Key? key}) : super(key: key);

  @override
  State<BNavigationBar> createState() => _BottomNavigationBarState();
}

@override
class _BottomNavigationBarState extends State<BNavigationBar> {
  List<Widget> _screen = [];
  List<Widget> _screenT = [];
  String username = '';
  String email = '';
  String userType = '';

  @override
  void initState() {
    super.initState();
    getUserNameAndEmail();
    _updateScreen();
    _updateScreenT();
  }

  @override
  void dispose() {
    // Cancel any ongoing asynchronous operations or listeners here
    super.dispose();
  }

  Future<void> getUserNameAndEmail() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot snap = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();
        if (mounted) {
          setState(() {
            username = snap['username'];
            email = snap['email'];
            userType = snap['userType'];
          });
        }
      }
    } catch (e) {
      // Handle any errors that occur during the asynchronous operation
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void _updateScreen() {
    setState(() {
      _screen = [
        const HomePage(),
        const PropertiesList(),
        const SearchScreen(),
        const FavoriteScreen(),
        const ProfileScreen(),
      ];
    });
  }

  void _updateScreenT() {
    setState(() {
      _screenT = [
        const UploadDataPage(),
        const PropertiesList(),
        const FavoriteScreen(),
        const ProfileScreen(),
      ];
    });
  }

  List<TabItem> getItems() {
    return [
      TabItem(
        icon: userType == 'buyer' || userType == ''
            ? FontAwesomeIcons.house
            : FontAwesomeIcons.plus,
        title: userType == 'buyer' ? 'Home' : 'Post Details',
      ),
      TabItem(
        icon: Icons.location_city,
        title: userType == 'buyer' ? 'Properties' : 'My Properties',
      ),
      if (userType == 'buyer' || userType == '')
        const TabItem(
          icon: Icons.search_sharp,
          title: 'Search',
        ),
      const TabItem(
        icon: Icons.favorite,
        title: 'Favorite',
      ),
      const TabItem(
        icon: Icons.account_box,
        title: 'Profile',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final items = getItems();

    return Scaffold(
      body: userType == 'buyer' || userType == ''
          ? _screen[widget.currentIndex]
          : _screenT[widget.currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xffEBEBEB),
              width: 1.0,
            ),
          ),
        ),
        child: BottomBarSalomon(
          backgroundSelected: const Color(0xff1E3C64),
          enableShadow: true,
          items: items,
          backgroundColor: Colors.white,
          color: Theme.of(context).primaryColor,
          colorSelected: Theme.of(context).colorScheme.secondary,
          indexSelected: widget.currentIndex,
          onTap: (int index) => setState(
            () {
              widget.currentIndex = index;
            },
          ),
        ),
      ),
    );
  }
}
