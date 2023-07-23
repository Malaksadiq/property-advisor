import 'package:flutter/material.dart';

class UploadImageWidgett extends StatelessWidget {
  final Function()? fromGallery;
  // final Function()? fromCamera;
  const UploadImageWidgett({Key? key, this.fromGallery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.2,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: fromGallery,
            child: Container(
              height: 36,
              width: 140,
              decoration: BoxDecoration(
                color: const Color(0xffEBEBEB),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/images/imageb.png',
                    width: 20,
                    color: const Color(0xff1E3C64),
                    height: 20,
                  ),
                  Text(
                    "From Gallery",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            // onTap: fromCamera,
            child: Container(
              height: 36,
              width: 140,
              decoration: BoxDecoration(
                color: const Color(0xffEBEBEB),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/images/camera.png',
                    width: 20,
                    color: const Color(0xff1E3C64),
                    height: 20,
                  ),
                  Text(
                    "From Camera",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// class UploadLogo extends StatelessWidget {
//   final Function()? fromGallery;
//   const UploadLogo({
//     Key? key,
//     this.fromGallery,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       height: MediaQuery.of(context).size.height * 0.1,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         border: Border.all(
//           color: Colors.grey,
//           width: 1.0,
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           InkWell(
//             onTap: fromGallery,
//             child: Container(
//               height: 36,
//               width: 140,
//               decoration: BoxDecoration(
//                 color: const Color(0xffEBEBEB),
//                 border: Border.all(
//                   color: Colors.grey,
//                   width: 1.0,
//                 ),
//                 borderRadius: BorderRadius.circular(5.0),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Image.asset(
//                     'assets/images/imageb.png',
//                     width: 20,
//                     height: 20,
//                   ),
//                   Text(
//                     "From Gallery",
//                     style: TextStyle(color: Theme.of(context).primaryColor),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//         ],
//       ),
//     );
//   }
// }
