import 'package:finall/feature/Providers/data_layer/models/providersClass.dart';
import 'package:finall/feature/categories/data_layer/models/categoryClass.dart';
import 'package:finall/feature/subcategory/data_layer/source/subcategory_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Subcategorycontroller extends GetxController {
  final SubCategoryService subCategoryService = SubCategoryService();
  RxBool isloading = false.obs;
  RxInt selectedIndex = 0.obs;
  RxList<SubCategoryClass> subcategories = <SubCategoryClass>[].obs;
  RxList<Provider> subprovider = <Provider>[].obs;
  RxList<Provider> filteredProviders = <Provider>[].obs;   

  int? categoryId;

  Future<void> loadsubCategories(int id) async {
    try {
      isloading.value = true;
      categoryId = id;
      subcategories.value = await subCategoryService.getSubCategories(
        categoryId!,
      );
      isloading.value = false;
    } catch (e) {
      isloading.value = false;
      Get.snackbar(
        'Categories loading failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.black,
      );
    }
  }

  Future<void> loadsubprovider(int id) async {
    try {
      isloading.value = true;
      categoryId = id;
      subprovider.value = await subCategoryService.getSubprovider(categoryId!);
      filteredProviders.value = subprovider;

      isloading.value = false;
    } catch (e) {
      isloading.value = false;
      Get.snackbar(
        'subprovider loading failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.black,
      );
    }
  }

  void filterBySubCategory(int subCategoryId) {
    filteredProviders.value = subprovider
        .where((p) => p.subCategory.id == subCategoryId)
        .toList();
  }

  void showAll() {
    filteredProviders.value = subprovider;
  }

  void selectsubCategory(int index) {
    selectedIndex.value = index;
     subcategories.refresh();
  }

  // @override
  // void onInit() {
  //   loadsubCategories();
  //   super.onInit();
  // }
}

