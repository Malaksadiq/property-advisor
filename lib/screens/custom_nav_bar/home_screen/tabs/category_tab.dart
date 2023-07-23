// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:property_app/screens/custom_nav_bar/home_screen/tabs/tab_widgets/properties_page.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});
  // final category = CATEGORIES;
  void navigateToCategoryProperties(
      {required BuildContext context,
      required String propertyType,
      required String title}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TPropertiesPage(
          propertyType: propertyType,
          pageTitle: title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
            // set shrinkWrap to true to size GridView based on its content
            // physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0.0,
              childAspectRatio: 1.50,
              mainAxisSpacing: 3.0,
            ),
            children: [
              Category(
                cIcon: Image.asset(
                  'assets/images/home (1).png',
                  width: 24,
                  height: 24,
                  color: const Color(0xffEC9E37),
                ),
                cTitle: 'Home',
                onTap: () {
                  navigateToCategoryProperties(
                      context: context, propertyType: 'Home', title: 'Home');
                },
              ),
              Category(
                cIcon: Image.asset(
                  'assets/images/skyscrapers.png',
                  width: 24,
                  height: 24,
                  color: const Color(0xffEC9E37),
                ),
                cTitle: 'Commercial',
                onTap: () {
                  navigateToCategoryProperties(
                      context: context,
                      propertyType: 'Commercial',
                      title: 'Commercial');
                },
              ),
              Category(
                cIcon: Image.asset(
                  'assets/images/residential.png',
                  width: 24,
                  height: 24,
                  color: const Color(0xffEC9E37),
                ),
                cTitle: 'Residential',
                onTap: () {
                  navigateToCategoryProperties(
                      context: context,
                      propertyType: 'Residential',
                      title: 'Residential');
                },
              ),
              Category(
                cIcon: Image.asset(
                  'assets/images/indus.png',
                  width: 24,
                  height: 24,
                  color: const Color(0xffEC9E37),
                ),
                cTitle: 'Industrial',
                onTap: () {
                  navigateToCategoryProperties(
                      context: context,
                      propertyType: 'Industrial',
                      title: 'Industrial');
                },
              ),
              Category(
                cIcon: Image.asset(
                  'assets/images/office-building.png',
                  width: 24,
                  height: 24,
                  color: const Color(0xffEC9E37),
                ),
                cTitle: 'Office',
                onTap: () {
                  navigateToCategoryProperties(
                      context: context,
                      propertyType: 'Office',
                      title: 'Office');
                },
              ),
              Category(
                cIcon: Image.asset(
                  'assets/images/apartment (1).png',
                  width: 24,
                  height: 24,
                  color: const Color(0xffEC9E37),
                ),
                cTitle: 'Apartment',
                onTap: () {
                  navigateToCategoryProperties(
                      context: context,
                      propertyType: 'Apartment',
                      title: 'Apartment');
                },
              ),
              Category(
                cIcon: Image.asset(
                  'assets/images/store.png',
                  width: 24,
                  height: 24,
                  color: const Color(0xffEC9E37),
                ),
                cTitle: 'Shops',
                onTap: () {
                  navigateToCategoryProperties(
                      context: context, propertyType: 'Shops', title: 'Shops');
                },
              ),
              Category(
                cIcon: Image.asset(
                  'assets/images/plaza.png',
                  width: 24,
                  height: 24,
                  color: const Color(0xffEC9E37),
                ),
                cTitle: 'Plaza',
                onTap: () {
                  navigateToCategoryProperties(
                      context: context, propertyType: 'Plaza', title: 'Plaza');
                },
              ),
            ]),
      ),
    );
  }
}

class Category extends StatelessWidget {
  final Function()? onTap;
  final Widget cIcon;
  final String cTitle;
  const Category({
    Key? key,
    required this.onTap,
    required this.cIcon,
    required this.cTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        // ignore: sized_box_for_whitespace
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              cIcon,
              const SizedBox(height: 15),
              Text(
                cTitle,
                style: const TextStyle(
                  // color: Color(0xffEC9E37),
                  color: Colors.black,
                  // color:
                  //     Theme.of(context).colorScheme.secondary,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
