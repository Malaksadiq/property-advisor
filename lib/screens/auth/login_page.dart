// ignore_for_file: library_private_types_in_public_api, unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:property_app/app_widgets/custom_app_bar.dart';
import 'package:property_app/screens/auth/signup_page.dart';
import 'package:property_app/services/auth_services.dart';

import '../../const/const.dart';
import 'auth_widgets/auth_custom_button.dart';
import 'auth_widgets/auth_textfeild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool loading = false;
  // UserType selectedUserType = UserType.user;
  UserType selectedUserType = UserType.buyer;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  signIn() {
    AuthServices.signIn(
      context: context,
      email: _emailController.text,
      pass: _passwordController.text,
      userType: selectedUserType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        automaticallyImplyLeadingg: false,
        title: 'Login',
        toolbarHeight: 50,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    color: const Color(0xffEBEBEB),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(
                                    image: AssetImage(
                                      'assets/images/1.png',
                                    ),
                                    height: 60,
                                    width: 60),
                                // const SizedBox(width: 10),
                                Text(
                                  'Property Advisor',
                                  style: authTextStyle.copyWith(fontSize: 22),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            const Text(
                              'Please login or signup to continue',
                              style: authTextStyle,
                            ),
                            const SizedBox(height: 20.0),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  AuthCustomTextField(
                                    controller: _emailController,
                                    labelText: 'Enter Email',
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Email';
                                      }
                                      final bool isEmail = RegExp(
                                              r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$')
                                          .hasMatch(value);
                                      if (!isEmail) {
                                        return 'Enter a valid Email';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10.0),
                                  AuthCustomTextField(
                                    controller: _passwordController,
                                    labelText: 'Password',
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Password';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            Center(
                              child: SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: TElevatedButton(
                                  bText: 'Login',
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        loading = !loading;
                                      });
                                      signIn();
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            Center(
                              child: GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  'Forgot Password?',
                                  style: authTextStyle,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    const SizedBox(width: 2),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupPage()));
                      },
                      child: Text(
                        'SignUp',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
