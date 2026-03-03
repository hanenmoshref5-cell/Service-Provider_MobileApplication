import 'package:finall/feature/Providers/busness_logic_layer/providerscontroller.dart';
import 'package:flutter/material.dart';

class Gallery extends StatelessWidget {
  Gallery({super.key});
  final Providerscontroller controller = Providerscontroller();
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: controller.galleryImages.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              controller.galleryImages[index],
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
