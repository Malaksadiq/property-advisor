import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:property_app/app_widgets/app_drawer.dart';
import 'package:property_app/app_widgets/custom_app_bar.dart';
import 'package:property_app/app_widgets/property_item.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<String> favouriteItemIds = [];
  String userType = '';

  @override
  void initState() {
    getIds();
    super.initState();
  }

  Future<void> getIds() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      List<dynamic> favouriteItems = snap['favourite'];
      List<String> itemIds =
          favouriteItems.map((item) => item.toString()).toList();
      setState(() {
        favouriteItemIds = itemIds;
        userType = snap['userType'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(favouriteItemIds.length);
    }
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        automaticallyImplyLeadingg: true,
        title: 'Your Favorites',
        toolbarHeight: 50,
      ),
      body: (favouriteItemIds.isEmpty && userType.isEmpty)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Sign up to view favorites',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            )
          : (favouriteItemIds.isEmpty)
              ? const Center(
                  child: Text(
                    'No favorites',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              : ListView.builder(
                  itemCount: favouriteItemIds.length,
                  itemBuilder: (context, index) {
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("propertyDetails")
                          .doc(favouriteItemIds[index].toString())
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        var favouriteMap = snapshot.data?.data();
                        if (favouriteMap != null) {
                          return PropertyItem(
                            pImageUrl: favouriteMap['images'][0],
                            pTitle: favouriteMap['title'].toString(),
                            pLocation: favouriteMap['selectedCity'].toString(),
                            id: favouriteMap['properId'].toString(),
                            pPrice: favouriteMap['amount'].toString(),
                            baths: favouriteMap['bathrooms'].toString(),
                            beds: favouriteMap['bedroom'].toString(),
                            data: favouriteMap,
                          );
                        } else {
                          return const Text(
                            'No favourites',
                            style: TextStyle(color: Colors.black),
                          );
                        }
                      },
                    );
                  },
                ),
    );
  }
}
