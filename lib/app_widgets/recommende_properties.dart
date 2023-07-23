import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:property_app/screens/custom_nav_bar/property_screen/property_detail_screen.dart';

class RecommendedProperties extends StatefulWidget {
  final String forSale;
  final String location;
  final int? price;
  final String image;
  final String id;
  final dynamic data;

  const RecommendedProperties({
    this.data,
    required this.id,
    Key? key,
    required this.image,
    required this.forSale,
    required this.location,
    required this.price,
  }) : super(key: key);

  @override
  State<RecommendedProperties> createState() => _RecommendedPropertiesState();
}

class _RecommendedPropertiesState extends State<RecommendedProperties> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PropertyDetailScreen(data: widget.data),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            // color: Theme.of(context).primaryColor,
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.49,
              height: MediaQuery.of(context).size.height * 0.13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffEBEBEB),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.forSale,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.height * 0.21,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 12,
                        ),
                        Flexible(
                          child: Text(
                            widget.location,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      // const Text(
                      //   'Starting From :',
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 10,
                      //   ),
                      // ),
                      Text(
                        NumberFormat.currency(
                          locale: 'en_PK',
                          symbol: 'PKR ',
                        ).format(int.parse(
                          widget.price.toString(),
                        )),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      // Text(
                      //   widget.price.toString(),
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 12,
                      //   ),
                      // ),
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
