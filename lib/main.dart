import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:property_app/app_widgets/app_drawer.dart';

import 'Screens/custom_nav_bar/home_screen/home_screen.dart';
import 'Screens/custom_nav_bar/nav_bar_screen.dart';
import 'Screens/custom_nav_bar/property_screen/properties_screen.dart';
import 'Screens/splash_screen/splash_screen.dart';
import 'screens/custom_nav_bar/property_screen/property_detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Property App',
      theme: ThemeData(
          primaryColor: const Color(0xff1E3C64),
          textTheme: const TextTheme(
            titleMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: const Color(0xffEC9E37))),
      initialRoute: '/',
      builder: EasyLoading.init(),
      routes: {
        '/': (context) => const SplashPage(),
        HomePage.routName: (context) => const HomePage(),
        'BNavigationBar': (context) => BNavigationBar(0),
        'properties-screen': (context) => const PropertiesList(),
        PropertyDetailScreen.routName: (context) =>
            const PropertyDetailScreen(),
        'AppDrawer': (context) => const AppDrawer(),
      },
    );
  }
}
