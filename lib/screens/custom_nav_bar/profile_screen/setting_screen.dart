// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_app/app_widgets/app_drawer.dart';
import 'package:property_app/app_widgets/custom_app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String username = '';
  String email = '';

  getUserNameAndEmail() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = snap['username'];
      email = snap['email'];
    });
  }

  final auth = FirebaseAuth.instance;
  String selectedCountryCode = '';
  File? selectedImage;

  getImage(ImageSource source) async {
    XFile? pickedImage = await ImagePicker().pickImage(source: source);
    setState(() {
      selectedImage = File(pickedImage!.path);
    });
  }

  List<String> countryCodes = ['+92', '+1', '+44', '+61'];
  @override
  void initState() {
    getUserNameAndEmail();

    super.initState();
    selectedCountryCode =
        countryCodes[0]; // Assign the first country code as the default value
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        automaticallyImplyLeadingg: true,
        title: 'Profile',
        toolbarHeight: 60,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.maxFinite,
              height: 170,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 140,
                    bottom: 15,
                    child: CircleAvatar(
                      radius: 40,
                      // backgroundColor: const Color(0xffEBEBEB),
                      backgroundColor: Theme.of(context).primaryColor,
                      // backgroundImage: const AssetImage('assets/profile_picture.jpg'),
                      child: username.isNotEmpty
                          ? Text(
                              username.isNotEmpty
                                  ? username.substring(0, 1).toUpperCase()
                                  : '',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Icon(
                              Icons.person_2_outlined,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Text(
                          'Update Your Profile',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'PropertyAdvisor Account',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 18),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: nameController,
                    labelText: username.isNotEmpty ? username : 'Name',
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: emailController,
                    labelText: email.isNotEmpty ? email : 'Email',
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: phoneNumberController,
                    labelText: 'Phone Number',
                  ),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                            child: _isLoading == true
                                ? CircularProgressIndicator(
                                    color: Colors.black,
                                  )
                                : Text('Update Profile'),
                            //              () async {
                            //   try {
                            //     EasyLoading.show(status: "Please Wait");
                            //     FirebaseStorage fs = FirebaseStorage.instance;
                            //     Reference ref = fs.ref().child(
                            //         DateTime.now().millisecondsSinceEpoch.toString());
                            //     await ref.putFile(File(selectedImage!.path));
                            //     String url = await ref.getDownloadURL();

                            //     await FirebaseFirestore.instance
                            //         .collection("users")
                            //         .doc(FirebaseAuth.instance.currentUser!.uid)
                            //         .update({
                            //       "image": url,
                            //       "fullName": fullNameController.text,
                            //       "location": locationController.text,
                            //       "phone": phoneController.text,
                            //       "totalArea": areaController,
                            //     });
                            //     EasyLoading.dismiss();
                            //     Navigator.pop(context);
                            //   } on FirebaseAuthException catch (e) {
                            //     EasyLoading.showError(e.message.toString());
                            //     EasyLoading.dismiss();
                            //   }
                            // }
                            onPressed: () async {
                              setState(() {
                                // Show the loading indicator
                                _isLoading = true;
                              });

                              try {
                                // Update the name and email in Firebase
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                  'username': nameController.text,
                                  'email': emailController.text,
                                });

                                // Update the local state variables with the updated values
                                setState(() {
                                  username = nameController.text;
                                  email = emailController.text;
                                  _isLoading =
                                      false; // Hide the loading indicator
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Profile updated successfully.'),
                                  ),
                                );
                              } catch (error) {
                                setState(() {
                                  _isLoading =
                                      false; // Hide the loading indicator
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Failed to update profile. Please try again.'),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//  String name = nameController.text;
// String email = emailController.text;
// Update profile logic with the entered name and email
// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  String? counterTextt;

  CustomTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.counterTextt});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        counterText: counterTextt,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.0,
          ),
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}














// Row(
                  //   children: [
                  //     Expanded(
                  //       flex: 1,
                  //       child: DropdownButtonFormField<String>(
                  //         value: selectedCountryCode,
                  //         onChanged: (value) {
                  //           setState(() {
                  //             selectedCountryCode = value ?? '';
                  //           });
                  //         },
                  //         decoration: InputDecoration(
                  //           contentPadding: const EdgeInsets.symmetric(
                  //               vertical: 8, horizontal: 16),
                  //           labelText: 'Country Code',
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //         ),
                  //         items: countryCodes.map((code) {
                  //           return DropdownMenuItem(
                  //             value: code,
                  //             child: Text('+92'),
                  //           );
                  //         }).toList(),
                  //       ),
                  //     ),
                  //     SizedBox(width: 16),
                  //     Expanded(
                  //       flex: 3,
                  //       child: TextField(
                  //         controller: phoneNumberController,
                  //         decoration: InputDecoration(
                  //           labelText: 'Phone Number',
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),