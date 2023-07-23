import 'package:flutter/material.dart';
import 'package:property_app/app_widgets/custom_app_bar.dart';
import 'package:property_app/screens/custom_nav_bar/profile_screen/not_active_properties.dart';

import 'profile_widgets/active_properties.dart';
import 'profile_widgets/uploaded_properties.dart';

class MyProperties extends StatefulWidget {
  final currentIndex;
  const MyProperties({super.key, this.currentIndex});

  @override
  State<MyProperties> createState() => _MyPropertiesState();
}

class _MyPropertiesState extends State<MyProperties> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        automaticallyImplyLeadingg: false,
        title: 'My Properties',
        toolbarHeight: 50,
      ),
      body: DefaultTabController(
        length: 3, // length of tabs
        initialIndex: widget.currentIndex ?? 0,
        child: Column(
          children: <Widget>[
            TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.black,
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'Active'),
                Tab(text: 'Not Active'),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  AllProperties(),
                  ActiveProperties(),
                  NotActiveProperties(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
