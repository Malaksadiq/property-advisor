import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:property_app/app_widgets/app_drawer.dart';
import 'package:property_app/app_widgets/custom_app_bar.dart';
import 'package:property_app/app_widgets/property_item.dart';

class PropertiesList extends StatefulWidget {
  const PropertiesList({
    Key? key,
  }) : super(key: key);

  @override
  State<PropertiesList> createState() => _PropertiesListState();
}

class _PropertiesListState extends State<PropertiesList> {
  String? userType;
  Stream<QuerySnapshot>? propertiesStream;

  @override
  void initState() {
    getUserNameAndEmail();
    super.initState();
  }

  Future<void> getUserNameAndEmail() async {
    var user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot? snap; // Define snap variable

    if (user != null) {
      snap = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      if (snap.exists) {
        setState(() {
          userType = snap!['userType'];
        });
      }
    }

    setState(() {
      if (user == null || snap == null || userType != 'seller') {
        propertiesStream = FirebaseFirestore.instance
            .collection("propertyDetails")
            .snapshots();
      } else {
        propertiesStream = FirebaseFirestore.instance
            .collection("propertyDetails")
            .where("uid", isEqualTo: user.uid)
            .snapshots();
      }
    });
  }

  // Future<void> getUserNameAndEmail() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   setState(() {
  //     userType = snap['userType'];
  //     if (userType == 'seller') {
  //       propertiesStream = FirebaseFirestore.instance
  //           .collection("propertyDetails")
  //           .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //           .snapshots();
  //     } else {
  //       propertiesStream = FirebaseFirestore.instance
  //           .collection("propertyDetails")
  //           .snapshots();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      appBar: const CustomAppBar(
        automaticallyImplyLeadingg: true,
        title: 'Properties',
        toolbarHeight: 50,
      ),
      body: StreamBuilder(
        stream: propertiesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No properties available.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var propertyMap = snapshot.data!.docs[index];
                return PropertyItem(
                  data: propertyMap,
                  pImageUrl: propertyMap['images'][0].toString(),
                  pTitle: propertyMap['title'].toString(),
                  pLocation: propertyMap['selectedCity'].toString(),
                  id: "1",
                  pPrice: propertyMap['amount'].toString(),
                  baths: propertyMap['bathrooms'],
                  beds: propertyMap['bedroom'].toString(),
                );
              },
            );
          }
        },
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:property_app/app_widgets/app_drawer.dart';
// import 'package:property_app/app_widgets/custom_app_bar.dart';
// import 'package:property_app/app_widgets/property_item.dart';

// class PropertiesList extends StatefulWidget {
//   const PropertiesList({
//     super.key,
//   });

//   @override
//   State<PropertiesList> createState() => _PropertiesListState();
// }

// class _PropertiesListState extends State<PropertiesList> {
//   String userType = '';

//   getUserNameAndEmail() async {
//     DocumentSnapshot snap = await FirebaseFirestore.instance
//         .collection("users")
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .get();
//     setState(() {
//       userType = snap['userType'];
//     });
//   }

//   @override
//   void initState() {
//     getUserNameAndEmail();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       drawer: const AppDrawer(),
//       appBar: const CustomAppBar(
//         automaticallyImplyLeadingg: true,
//         title: 'Properties',
//         toolbarHeight: 50,
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection(
//               "propertyDetails",
//             )
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 var propertyMap = snapshot.data!.docs[index];
//                 return PropertyItem(
//                   data: propertyMap,
//                   pImageUrl: propertyMap['image'].toString(),
//                   pTitle: propertyMap['title'].toString(),
//                   pLocation: propertyMap['selectedCity'].toString(),
//                   id: "1",
//                   pPrice: propertyMap['amount'].toString(),
//                   baths: propertyMap['bathrooms'].toString(),
//                   beds: propertyMap['bedroom'].toString(),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
