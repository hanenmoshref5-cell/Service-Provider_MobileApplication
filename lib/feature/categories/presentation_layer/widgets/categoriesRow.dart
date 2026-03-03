import 'package:finall/feature/categories/business_logic_layer/categorycontroller.dart';
import 'package:finall/feature/categories/data_layer/models/categoryClass.dart';

import 'package:finall/feature/subcategory/presentation_layer/screens/subPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Categoriesrow extends StatelessWidget {
  Categoriesrow({super.key, required this.categories});
  final Categoriescontroller controller = Get.put(Categoriescontroller());
  final List<CategoryClass> categories;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),

        Obx(
          () => SizedBox(
            height: 95,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: controller.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final isSelected = controller.selectedIndex.value == index;
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      () => Subpage(category: controller.categories[index]),
                    );

                    controller.selectCategory(index);
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? const Color(0xFFFFF3E0)
                              : Colors.grey.shade100,
                        ),
                        child: Center(
                          child: SvgPicture.string(
                            controller.categories[index].svgImage,
                            width: 26,
                            height: 26,

                            color: isSelected
                                ? const Color(0xFFFF6F00)
                                : Colors.grey,
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),
                      Text(
                        controller.categories[index].name,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected
                              ? const Color(0xFFFF6F00)
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
