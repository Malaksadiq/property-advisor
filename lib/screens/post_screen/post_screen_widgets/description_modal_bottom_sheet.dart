// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:property_app/const/const.dart';

class DescriptionModalBottomSheet extends StatefulWidget {
  final TextEditingController descriptionController;
  final Function(String) onDescriptionChanged;

  const DescriptionModalBottomSheet({
    super.key,
    required this.descriptionController,
    required this.onDescriptionChanged,
  });

  @override
  _DescriptionModalBottomSheetState createState() =>
      _DescriptionModalBottomSheetState();
}

class _DescriptionModalBottomSheetState
    extends State<DescriptionModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    // var description = widget.descriptionController.text;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Property Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      style: authTextStyle,
                      controller: widget.descriptionController,
                      maxLines: null,
                      onChanged: (value) {
                        setState(() {
                          widget.onDescriptionChanged(value);
                        });
                      },
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Describe your property in detail',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
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



// import 'package:flutter/material.dart';

// class DescriptionModalBottomSheet extends StatelessWidget {
//   final Function onTap;
//   final TextEditingController descriptionController;

//   const DescriptionModalBottomSheet({
//     Key? key,
//     required this.onTap,
//     required this.descriptionController,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         height: MediaQuery.of(context).size.height * 0.97,
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Property Description',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: onTap as void Function()?,
//                   child: const Text(
//                     'Done',
//                     style: TextStyle(
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             const Divider(),
//             Expanded(
//               child: Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: TextFormField(
//                     controller: descriptionController,
//                     maxLines: null,
//                     keyboardType: TextInputType.multiline,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Describe your property in detail',
//                       hintStyle: TextStyle(fontWeight: FontWeight.normal),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
