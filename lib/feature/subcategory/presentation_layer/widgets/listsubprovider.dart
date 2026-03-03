import 'package:finall/feature/Providers/busness_logic_layer/providerscontroller.dart';
import 'package:finall/feature/Providers/presentation_layer/screens/prodetails.dart';

import 'package:finall/feature/subcategory/business_logic_layer/subcategorycontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Listsubproviders extends StatefulWidget {
  final int subCategoryId;

  const Listsubproviders({super.key, required this.subCategoryId});

  @override
  State<Listsubproviders> createState() => _ListsubprovidersState();
}

class _ListsubprovidersState extends State<Listsubproviders> {
  final Providerscontroller providerscontroller = Get.put(
    Providerscontroller(),
  );
  final Subcategorycontroller subcategorycontroller = Get.put(
    Subcategorycontroller(),
  );



  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (providerscontroller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (providerscontroller.providers.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            " Not found",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        );
      }

      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: subcategorycontroller.filteredProviders.length,
        itemBuilder: (context, index) {
          final provider = subcategorycontroller.filteredProviders[index];

          return Container(
            margin: const EdgeInsets.only(top: 16),
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xffB0B0B0)),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Image.network(
                  provider.imageUrl,
                  width: 100,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 100,
                    height: 90,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(width: 8),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.providerName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Row(
                        children: [
                          const Icon(
                            Icons.remove_red_eye,
                            size: 18,
                            color: Color(0xffFF6F00),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            provider.views.toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),

                      const Spacer(),

                      Image.asset("assets/img/home_img/Frame 1597882050.png"),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () {
                    Get.to(ProviderDetailsScreen(provider: provider));
                  },
                  icon: Image.asset(
                    "assets/img/home_img/angle-circle-right (1) 1.png",
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
