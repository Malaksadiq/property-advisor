// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:property_app/services/auth_services.dart';
import '../../const/const.dart';
import 'auth_widgets/auth_custom_button.dart';
import 'auth_widgets/auth_textfeild.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  bool isDealerSelected = false;

  registerUser() {
    AuthServices.signUp(
      context: context,
      username: _usernameController.text,
      email: _emailcontroller.text,
      pass: _passwordController.text,
      userType: isDealerSelected ? UserType.seller : UserType.buyer,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
              ),
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                color: const Color(0xffEBEBEB),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage(
                              'assets/images/1.png',
                            ),
                            height: 40,
                            width: 40,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Property Advisor',
                            style: authTextStyle.copyWith(fontSize: 22),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      AuthCustomTextField(
                        controller: _usernameController,
                        labelText: 'Enter your Name',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      AuthCustomTextField(
                        controller: _emailcontroller,
                        labelText: 'Enter Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an email or phone number';
                          }

                          final bool isEmail = RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$')
                              .hasMatch(value);

                          if (!isEmail) {
                            return 'Please enter a valid email or phone number';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      AuthCustomTextField(
                        controller: _passwordController,
                        labelText: 'Enter password',
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Switch(
                            value: isDealerSelected,
                            onChanged: (value) {
                              setState(() {
                                isDealerSelected = value;
                                if (kDebugMode) {
                                  print(isDealerSelected);
                                }
                              });
                            },
                            activeColor: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Join as a Dealer',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 50,
                        child: TElevatedButton(
                          bText: 'Sign Up',
                          onPressed: () {
                            setState(() {});
                            if (_formKey.currentState!.validate()) {
                              registerUser();
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          const SizedBox(width: 4.0),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
