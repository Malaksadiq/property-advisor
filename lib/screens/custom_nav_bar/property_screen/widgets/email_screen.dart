import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:property_app/const/const.dart';
import 'package:property_app/screens/auth/auth_widgets/auth_custom_button.dart';
import 'package:property_app/screens/custom_nav_bar/profile_screen/setting_screen.dart';

class SendMail extends StatefulWidget {
  const SendMail({Key? key}) : super(key: key);

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
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

  List<String> countryCodes = ['+92', '+1', '+44', '+61'];
  @override
  void initState() {
    getUserNameAndEmail();

    super.initState();
    selectedCountryCode =
        countryCodes[0]; // Assign the first country code as the default value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context)
              .colorScheme
              .secondary, // Set the desired color here
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Email',
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 14.0, left: 14.0, top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                counterTextt: 'Name',
                controller: nameController,
                labelText: username.isNotEmpty ? username : 'Name',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                counterTextt: 'Email',
                controller: emailController,
                labelText: email.isNotEmpty ? email : 'Email',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                counterTextt: 'Phone Number',
                controller: phoneNumberController,
                labelText: 'Phone Number',
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                maxLines: 6,
                decoration: InputDecoration(
                  counterText: 'Description',
                  // labelText: 'Description',
                  hintText: 'Description',
                  hintStyle: authTextStyle,
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),

              const SizedBox(height: 32),
              // const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: CElevatedButton(
                        loading: false,
                        bText: 'Send',
                        onPressed: () {
                          // String name = nameController.text;
                          // String email = emailController.text;
                          // String phoneNumber = phoneNumberController.text;
                          // String description = descriptionController.text;

                          // Send email logic with the entered information
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
