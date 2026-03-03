import 'package:finall/feature/Offers/busness_logic_layer/offerscontroller.dart';
import 'package:finall/feature/Offers/presentation_layer/screens/Offerspage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bestoffers extends StatelessWidget {
  Bestoffers({super.key});
  final OfferController controller = Get.put(OfferController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 20,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.only(left: 20),
          child: Image.asset(
            "assets/img/home_img/Best Offers just for you.png",
          ),
        ),
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SizedBox(
            height: 163,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: controller.offers.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(Offerspage());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 143,
                    child: Image.network(
                      controller.offers[index].image,
                      height: 162,
                      width: 143,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
