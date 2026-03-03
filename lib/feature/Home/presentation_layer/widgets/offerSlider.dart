import 'package:carousel_slider/carousel_slider.dart';
import 'package:finall/feature/Home/business_logic_layer/Home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Offerslider extends StatelessWidget {
  Offerslider({super.key});

  final HomeSliderController controller = Get.put(HomeSliderController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          if (controller.isLoading.value) {
            return const SizedBox(
              height: 150,
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (controller.slider.isEmpty) {
            return const SizedBox(
              height: 150,
              child: Center(child: Text('No sliders found')),
            );
          }

          return CarouselSlider(
            items: controller.slider.map((item) {
              return _sliderItem(item.image);
            }).toList(),
            options: CarouselOptions(
              height: 150,
              autoPlay: true,
              viewportFraction: 0.9,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                controller.onPageChanged(index);
              },
            ),
          );
        }),

        const SizedBox(height: 10),

        Obx(() {
          if (controller.slider.isEmpty) {
            return const SizedBox(); 
          }

          return AnimatedSmoothIndicator(
            activeIndex: controller.currentIndex.value,
            count: controller.slider.length,
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              spacing: 6,
              activeDotColor: const Color(0xFFFF6F00),
              dotColor: Colors.grey.shade300,
            ),
          );
        }),
      ],
    );
  }

  Widget _sliderItem(String imageUrl) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          imageUrl,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
