import 'package:finall/feature/Providers/busness_logic_layer/providerscontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderGalleryView extends StatelessWidget {
  
  final Providerscontroller controller = Get.find<Providerscontroller>();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            "assets/images/tire.png",
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
