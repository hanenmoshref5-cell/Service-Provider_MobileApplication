import 'package:finall/common/widgets/contactButton.dart';
import 'package:finall/feature/Home/business_logic_layer/home_controller.dart';
import 'package:finall/feature/Providers/data_layer/models/providersClass.dart';
import 'package:finall/feature/Providers/presentation_layer/screens/ProviderGallerySlider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderDetailsScreen extends StatefulWidget {
  final Provider  provider;

  const ProviderDetailsScreen({super.key, required this.provider});

  @override
  State<ProviderDetailsScreen> createState() => _ProviderDetailsScreenState();
}

final HomeSliderController controller = Get.put(HomeSliderController());

class _ProviderDetailsScreenState extends State<ProviderDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final provider = widget.provider;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                provider.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                height: 250,
              ),
              Positioned(
                top: 20,
                left: 15,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Image.asset("assets/img/Frame 1261154538.png"),
                ),
              ),
              Positioned(
                top: 230,
                right: 0,
                left: 0,
                child: Container(
                  alignment: Alignment.centerRight,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      provider.providerName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      provider.shopName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Image.asset("assets/img/n/State4.png"),
                      Text("Maza"),
                      SizedBox(width: 10),
                      Image.asset("assets/img/n/building 1.png"),
                      Text("Maza"),
                    ],
                  ),
                ),
              ],
            ),
          ),

          TabBar(
            controller: tabController,
            labelColor: Color(0xffFF6F00),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xffFF6F00),
            tabs: const [
              Tab(text: "Details"),
              Tab(text: "Gallery"),
              Tab(text: "Offers"),
            ],
          ),

          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                _detailsTab(provider),
                _galleryTab(provider),
                _offersTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailsTab(Provider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Description",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(provider.description),

          const SizedBox(height: 20),

          const Text(
            "Contact Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          Wrap(
            children: [
              Contactbutton(title: "phone number", icon: Icons.call),
              Contactbutton(title: "Facebook", icon: Icons.facebook),
              Contactbutton(title: "Message", icon: Icons.message),
            ],
          ),

          const SizedBox(height: 20),

          if (provider.address != null)
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 6),
                Text(provider.address!),
              ],
            ),
        ],
      ),
    );
  }

  // ================= GALLERY TAB =================
  Widget _galleryTab(Provider provider) {
    if ((provider.gallery).isEmpty) {
      return const Center(child: Text("No images available"));
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ProviderGallerySlider(images: provider.gallery),
    );
  }

  // ================= OFFERS TAB =================
  Widget _offersTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return Container(
          width: 30,
          height: 20,
          color: const Color.fromARGB(255, 83, 83, 83),
        );
      },
    );
  }
}