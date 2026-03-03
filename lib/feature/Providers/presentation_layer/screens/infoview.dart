// import 'package:finall/feature/Providers/busness_logic_layer/providerscontroller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ProviderInfo extends StatelessWidget {
//   final Providerscontroller controller = Get.put(Providerscontroller());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return const Center(child: CircularProgressIndicator());
//       }

//       final provider = controller.providers;

//       return SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // العنوان
//             Row(
//               children: [
//                 const Icon(Icons.location_on, color: Colors.orange),
//                 const SizedBox(width: 6),
//                 Text(
//                   provider.address,
//                   style: const TextStyle(fontSize: 14),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 16),

//             // الوصف
//             const Text(
//               "Description",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               provider.description,
//               style: const TextStyle(
//                 fontSize: 14,
//                 height: 1.5,
//                 color: Colors.black87,
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }
