
import 'package:finall/feature/subcategory/business_logic_layer/subcategorycontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Rowsubcategory extends StatefulWidget {
  final int categoryId;

  const Rowsubcategory({super.key, required this.categoryId});

  @override
  State<Rowsubcategory> createState() => _RowsubcategoryState();
}

class _RowsubcategoryState extends State<Rowsubcategory> {
  final Subcategorycontroller controller = Get.find<Subcategorycontroller>();

  @override
  void initState() {
    super.initState();
    controller.loadsubCategories(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isloading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return SizedBox(
        height: 100,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                controller.selectedIndex.value = -1;
                controller.showAll();
              },
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    margin: const EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.selectedIndex.value == -1
                          ? const Color(0xFFFFF3E0)
                          : Colors.grey.shade200,
                    ),
                    child: Icon(
                      Icons.apps,
                      color: controller.selectedIndex.value == -1
                          ? const Color(0xFFFF6F00)
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "All",
                    style: TextStyle(
                      fontSize: 12,
                      color: controller.selectedIndex.value == -1
                          ? const Color(0xFFFF6F00)
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: controller.subcategories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final sub = controller.subcategories[index];
                  final isSelected = controller.selectedIndex.value == sub.id;

                  return GestureDetector(
                    onTap: () {
                      controller.selectedIndex.value = sub.id;
                      controller.filterBySubCategory(sub.id);
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
                              sub.svgImage,
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
                          sub.name,
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
          ],
        ),
      );
    });
  }
}
