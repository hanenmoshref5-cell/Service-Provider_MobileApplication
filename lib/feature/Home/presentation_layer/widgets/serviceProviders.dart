import 'package:finall/feature/Providers/busness_logic_layer/providerscontroller.dart';
import 'package:finall/feature/Providers/data_layer/models/providersClass.dart';
import 'package:finall/feature/Providers/presentation_layer/screens/prodetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceProviders extends StatelessWidget {
  ServiceProviders({super.key});

  final Providerscontroller providerscontroller = Get.put(
    Providerscontroller(),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Obx(() {
        if (providerscontroller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: providerscontroller.providers.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final provider = providerscontroller.providers[index];
            return _providerCard(provider);
          },
        );
      }),
    );
  }

  Widget _providerCard(Provider provider) {
    return Container(
      width: 181,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              provider.imageUrl,
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 110,
                color: Colors.grey.shade200,
                child: const Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      provider.providerName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Get.to(ProviderDetailsScreen(provider: provider));
                      },
                      icon: Image.asset(
                        "assets/img/home_img/angle-circle-right (1) 1.png",
                        width: 30,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.remove_red_eye,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      provider.views.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                Image.asset("assets/img/home_img/Frame 1597882050.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
