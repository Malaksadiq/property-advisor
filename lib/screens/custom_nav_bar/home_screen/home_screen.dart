import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:property_app/Utils/lists.dart';
import 'package:property_app/app_widgets/app_drawer.dart';
import 'package:property_app/app_widgets/recommende_properties.dart';
import 'package:property_app/const/const.dart';
import 'package:property_app/screens/custom_nav_bar/home_screen/tabs/budget_tab.dart';
import 'package:property_app/screens/custom_nav_bar/home_screen/tabs/category_tab.dart';
import 'package:property_app/screens/custom_nav_bar/home_screen/tabs/cities_tab.dart';
import 'package:property_app/screens/custom_nav_bar/home_screen/tabs/societies_tab.dart';
import 'package:property_app/screens/custom_nav_bar/search_screen/search_screen.dart';
import 'package:property_app/screens/post_screen/post_screen_widgets/city_bottom_sheet.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  static const routName = 'Home-Page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String _hintText = 'Search for Properties';
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    // _filteredCities = kpkCities.toList();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        switch (_hintText) {
          case 'Search for Properties':
            _hintText = 'Search for Lands';
            break;
          case 'Search for Lands':
            _hintText = 'Search for Homes';
            break;
          case 'Search for Homes':
            _hintText = 'Search for Properties';
            break;
          default:
            _hintText = 'Search for Appartment';
            break;
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _tabController!.dispose();
    _stopTimer();
    super.dispose();
  }

  final _textController = TextEditingController();
  // String? _selectedCity;
  String? _selectedCity = kpkCities[0];

  void _showCitySelectionModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (ctx) {
        return CitySelectionModal(
          onCitySelected: (selectedCity) {
            setState(() {
              _selectedCity = selectedCity.toString();
            });
          },
          selectedCity: _selectedCity, // Pass the selected city to the modal
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(
          // widget.currentIndex,
          ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Property Advisor',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 110,
                // width: double.infinity,
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      TextField(
                        readOnly: true,
                        onTap: _selectedCity != null
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchScreen(
                                      selectedCityyy: _selectedCity,
                                    ),
                                  ),
                                );
                              }
                            : null,
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: _hintText,
                          hintStyle: authTextStyle.copyWith(fontSize: 14),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          prefixIcon: Icon(Icons.search,
                              color: Theme.of(context).primaryColor),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _selectedCity ?? 'Select a city',
                                style: authTextStyle.copyWith(
                                    fontWeight: FontWeight.w400),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_drop_down_circle_rounded,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  _showCitySelectionModal(context);
                                },
                                // tooltip: 'Select a city',
                              ),
                            ],
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //Different Categories
              DefaultTabController(
                length: 4, // length of tabs
                initialIndex: 0,
                child: Column(
                  children: <Widget>[
                    TabBar(
                      indicatorColor: Theme.of(context).primaryColor,
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Colors.black,
                      tabs: const [
                        Tab(text: 'Category'),
                        Tab(text: 'Budget'),
                        Tab(text: 'Cities'),
                        Tab(text: 'Dealers'),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height *
                          0.35, //height of TabBarView
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey, width: 0.5))),
                      child: const TabBarView(children: [
                        CategoryTab(),
                        BudgetTab(),
                        CitiesTab(),
                        SocietiesTab(),
                      ]),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recommended',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.24,
                        width: double.infinity,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("propertyDetails")
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var propertyMap = snapshot.data!.docs[index];
                                return RecommendedProperties(
                                  data: propertyMap,
                                  id: '1',
                                  forSale: 'For Sale',
                                  image: propertyMap['images'][0],
                                  location: propertyMap['selectedCity'],
                                  price: int.parse(
                                      propertyMap['amount'].toString()),
                                );
                              },
                              itemCount: snapshot.data!.docs.length,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
