// import 'package:finall/feature/Providers/busness_logic_layer/providerscontroller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ProviderHeader extends StatelessWidget {
//   final Providerscontroller controller = Get.put(Providerscontroller());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return const SizedBox(
//           height: 220,
//           child: Center(child: CircularProgressIndicator()),
//         );
//       }

//       final provider = controller.providers;

//       return Stack(
//         children: [
//           // صورة البروفايدر
//           Image.network(
//             provider.image,
//             height: 220,
//             width: double.infinity,
//             fit: BoxFit.cover,
//           ),

//           // Gradient
//           Container(
//             height: 220,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//                 colors: [
//                   Colors.black54,
//                   Colors.transparent,
//                 ],
//               ),
//             ),
//           ),

//           // المعلومات
//           Positioned(
//             bottom: 16,
//             left: 16,
//             right: 16,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   provider.shopName,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   provider.providerName,
//                   style: const TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Row(
//                   children: [
//                     const Icon(Icons.remove_red_eye,
//                         size: 16, color: Colors.white70),
//                     const SizedBox(width: 4),
//                     Text(
//                       provider.views.toString(),
//                       style: const TextStyle(color: Colors.white70),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }
