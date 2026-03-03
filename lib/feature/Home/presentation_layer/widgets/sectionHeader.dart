// import 'package:flutter/material.dart';

// class Sectionheader extends StatelessWidget {
//   Sectionheader({
//     super.key,
//     required String title,
//     required VoidCallback onTap,
//   });
//   String title;
//   void Function() onTap;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         textDirection: TextDirection.ltr,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w500,
//               color: Color(0xff2C371F),
//             ),
//           ),
//           TextButton(
//             onPressed: onTap,
//             child: const Text(
//               'Show All',
//               style: TextStyle(color: Color(0xFFFF6F00)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
