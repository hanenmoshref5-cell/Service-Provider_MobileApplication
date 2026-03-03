import 'package:finall/feature/categories/business_logic_layer/categorycontroller.dart';
import 'package:finall/common/widgets/appbar.dart';
import 'package:finall/common/widgets/searchBar.dart';
import 'package:finall/feature/subcategory/business_logic_layer/subcategorycontroller.dart';
import 'package:finall/feature/subcategory/presentation_layer/screens/subPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Categoriespage extends StatelessWidget {
  Categoriespage({Key? key}) : super(key: key);

  final Categoriescontroller categoriescontroller = Get.put(
    Categoriescontroller(),
  );
  final Subcategorycontroller subcategorycontroller = Get.put(
    Subcategorycontroller(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Appbar(texttitle: "All Categories", onPressed: () => Get.back()),
          Searchbarr(onchange: categoriescontroller.onSearchChanged),
          SizedBox(height: 20),

          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    if (categoriescontroller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (categoriescontroller.filteredCategories.isEmpty) {
                      return const Center(child: Text('No categories found'));
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: categoriescontroller.filteredCategories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      itemBuilder: (context, index) {
                        final item =
                            categoriescontroller.filteredCategories[index];

                        return InkWell(
                          onTap: () {
                            subcategorycontroller.loadsubCategories(
                              categoriescontroller.categories[index].id,
                            );

                            Get.to(
                              () => Subpage(
                                category:
                                    categoriescontroller.categories[index],
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffEAF0FC),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.string(
                                  item.svgImage,
                                  width: 33,
                                  height: 32,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffBFCBE3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
