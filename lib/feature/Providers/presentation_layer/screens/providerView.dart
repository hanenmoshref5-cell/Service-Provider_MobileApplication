// import 'package:finall/feature/Home/business_logic_layer/Home_controller.dart';
// import 'package:finall/feature/Home/presentation_layer/widgets/bestOffers.dart';
// import 'package:finall/feature/Providers/data_layer/models/providersClass.dart';
// import 'package:finall/common/widgets/contactButton.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';

// class ProviderDetailsScreen extends StatefulWidget {
//   final Provider provider;

//   const ProviderDetailsScreen({super.key, required this.provider});

//   @override
//   State<ProviderDetailsScreen> createState() => _ProviderDetailsScreenState();
// }

// final HomeSliderController controller = Get.put(HomeSliderController());

// class _ProviderDetailsScreenState extends State<ProviderDetailsScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController tabController;

//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = widget.provider;

//     return Scaffold(
//       appBar: AppBar(title: const Text("Provider Details"), centerTitle: true),

//       body: Column(
//         children: [
//           // ================= HEADER =================
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 // Profile Image
//                 CircleAvatar(
//                   radius: 40,
//                   backgroundImage: provider.imageUrl.isNotEmpty
//                       ? NetworkImage(provider.imageUrl)
//                       : null,
//                   child: provider.imageUrl.isEmpty
//                       ? const Icon(Icons.person, size: 40)
//                       : null,
//                 ),
//                 const SizedBox(width: 16),

//                 // Name + Shop + Category
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         provider.providerName,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         provider.shopName,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Text(
//                         provider.subCategory.name,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.blueGrey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // SVG Icon
//                 SizedBox(
//                   width: 45,
//                   height: 45,
//                   child: SvgPicture.string(provider.subCategory.svgImage),
//                 ),
//               ],
//             ),
//           ),

//           // ================= TABS =================
//           TabBar(
//             controller: tabController,
//             labelColor: Colors.blue,
//             unselectedLabelColor: Colors.grey,
//             indicatorColor: Colors.blue,
//             tabs: const [
//               Tab(text: "Details"),
//               Tab(text: "Gallery"),
//               Tab(text: "Offers"),
//             ],
//           ),

//           // ================= TAB CONTENT =================
//           Expanded(
//             child: TabBarView(
//               controller: tabController,
//               children: [
//                 // ========== DETAILS TAB ==========
//                 _detailsTab(provider),

//                 // ========== GALLERY TAB ==========
//                 // _galleryTab(provider),

//                 // ========== OFFERS TAB ==========
//                 _offersTab(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ================= DETAILS TAB =================
//   Widget _detailsTab(Provider provider) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Description
//           const Text(
//             "Description",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           Text(provider.description),

//           const SizedBox(height: 20),

//           // Contact Buttons
//           const Text(
//             "Contact Details",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 12),

//           Row(
//             children: [
//               Contactbutton(title: "phone number", icon: Icons.call),
//               Contactbutton(title: "Facebook", icon: Icons.facebook),
//               Contactbutton(title: "Message", icon: Icons.message),
//             ],
//           ),

//           const SizedBox(height: 20),

//           // Address
//           if (provider.address != null)
//             Row(
//               children: [
//                 const Icon(Icons.location_on, color: Colors.red),
//                 const SizedBox(width: 6),
//                 Text(provider.address!),
//               ],
//             ),
//         ],
//       ),
//     );
//   }

//   // ================= GALLERY TAB =================
//   // Widget _galleryTab(Provider provider) {
//   //   if (provider.gallery.isEmpty) {
//   //     return const Center(child: Text("No images available"));
//   //   }

//   // return GridView.builder(
//   //   padding: const EdgeInsets.all(16),
//   //   itemCount: provider.gallery.length,
//   //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//   //     crossAxisCount: 2,
//   //     mainAxisSpacing: 12,
//   //     crossAxisSpacing: 12,
//   //   ),
//   //   itemBuilder: (context, index) {
//   //     return ClipRRect(
//   //       borderRadius: BorderRadius.circular(12),
//   //       child: Image.network(provider.gallery[index], fit: BoxFit.cover),
//   //     );
//   //   },
//   // );
//   // return Offerslider(sliderItem: )
// }

// // ================= OFFERS TAB =================
// Widget _offersTab() {
//   return ListView.builder(
//     padding: const EdgeInsets.all(16),
//     itemCount: 3,
//     itemBuilder: (context, index) {
//       return Bestoffers();
//     },
//   );
// }

//   // ================= CONTACT BUTTON =================
//   // Widget _contactButton(IconData icon, String label) {
//   //   return Expanded(
//   //     child: Container(
//   //       height: 45,
//   //       margin: const EdgeInsets.symmetric(horizontal: 4),
//   //       decoration: BoxDecoration(
//   //         color: Colors.blue.shade50,
//   //         borderRadius: BorderRadius.circular(12),
//   //       ),
//   //       child: Row(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         children: [
//   //           Icon(icon, color: Colors.blue),
//   //           const SizedBox(width: 6),
//   //           Text(label, style: const TextStyle(color: Colors.blue)),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }

