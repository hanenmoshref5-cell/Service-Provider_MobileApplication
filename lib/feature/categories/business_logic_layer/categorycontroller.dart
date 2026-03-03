// import 'package:finall/feature/categories/data_layer/models/categoryClass.dart';
// import 'package:finall/feature/categories/data_layer/source/category_service.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';

// class CategoryController extends GetxController {
//   final CategoryService _categoryService = CategoryService();
//   RxBool isloading = false.obs;
//   RxList<CategoryClass> categories = <CategoryClass>[].obs;

//   Future<void> loadCategories() async {
//     try {
//       isloading.value = true;
//       categories.value = await _categoryService.getCategories();
//       isloading.value = false;
//     } catch (e) {
//       isloading.value = false;
//       Get.snackbar(
//         'Categories loading failed',
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         colorText: Colors.black,
//       );
//     }
//   }
//   // @override
//   // void onInit() {
//   //   loadCategories();
//   //   super.onInit();
//   // }

//   RxList<CategoryClass> filteredCategories = <CategoryClass>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     filteredCategories.value = categories;
//   }

// void search(String value) {
//   if (value.isEmpty) {
//     filteredCategories.value = categories;
//   } else {
//     filteredCategories.value = categories
//         .where(
//           (category) =>
//               category.name.toLowerCase().contains(value.toLowerCase()),
//         )
//         .toList();
//   }
// }

//   // void applyFilter(FilterType type) {
//   //   switch (type) {
//   //     case FilterType.az:
//   //       break;
//   //     case FilterType.za:
//   //       break;
//   //     case FilterType.reset:
//   //       break;
//   //   }
//   // }
// }

// import 'package:dio/dio.dart';
// import 'package:finall/feature/categories/data_layer/models/categoryClass.dart';
// import 'package:get/get.dart';

// class Categoriescontroller extends GetxController {
//   final Dio dio = Dio(BaseOptions(baseUrl: 'http://94.72.98.154:8085/api/'));

//   RxBool isLoading = false.obs;

//   RxList<CategoryClass> categories = <CategoryClass>[].obs;
//   RxList<CategoryClass> filteredCategories = <CategoryClass>[].obs;

//   RxString searchText = ''.obs;

//   Future<void> fetchCategories({String search = ''}) async {
//     try {
//       isLoading.value = true;

//       final response = await dio.get(
//         'categories',
//         queryParameters: search.isNotEmpty ? {'search': search} : null,
//       );

//       final data = CategoryClass.fromJsonList(response.data['data']);

//       categories.value = data;
//       filteredCategories.value = data;
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load categories');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void onSearchChanged(String value) {
//     searchText.value = value;
//     fetchCategories(search: value);
//   }

//   @override
//   void onInit() {
//     fetchCategories();
//     super.onInit();
//   }

//   RxInt selectedIndex = 0.obs;

//   void selectCategory(int index) {
//     selectedIndex.value = index;
//     categories.refresh();
//   }

//   var selectedTab = 0.obs;

//   var galleryImages = ['assets/images/tire1.png', 'assets/images/tire2.png'];

//   void changeTab(int index) {
//     selectedTab.value = index;
//   }
// }

import 'package:dio/dio.dart';
import 'package:finall/feature/categories/data_layer/models/categoryClass.dart';
import 'package:get/get.dart';

class Categoriescontroller extends GetxController {
  final Dio dio = Dio(BaseOptions(baseUrl: 'http://94.72.98.154:8085/api/'));

  RxBool isLoading = false.obs;

  RxList<CategoryClass> categories = <CategoryClass>[].obs;
  RxList<CategoryClass> filteredCategories = <CategoryClass>[].obs;
  RxString searchText = ''.obs;
  RxInt selectedIndex = 0.obs;

  RxList<SubCategoryClass> subCategories = <SubCategoryClass>[].obs;
  RxInt selectedSubCategoryId = (-1).obs;

  var selectedTab = 0.obs;
  var galleryImages = ['assets/images/tire1.png', 'assets/images/tire2.png'];

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories({String search = ''}) async {
    try {
      isLoading.value = true;

      final response = await dio.get(
        'categories',
        queryParameters: search.isNotEmpty ? {'search': search} : null,
      );

      final data = CategoryClass.fromJsonList(response.data['data']);

      categories.value = data;
      filteredCategories.value = data;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load categories');
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchChanged(String value) {
    searchText.value = value;
    fetchCategories(search: value);
  }

  void selectCategory(int index) {
    selectedIndex.value = index;
    categories.refresh();
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  Future<void> fetchSubCategories(int categoryId) async {
    selectedSubCategoryId.value = -1; 
    try {
      final response = await dio.get(
        'sub-categories',
        queryParameters: {'categoryId': categoryId},
      );

      final data = SubCategoryClass.fromJsonList(response.data['data']);
      subCategories.value = data;
    } catch (e) {
      subCategories.clear();
      Get.snackbar('Error', 'Failed to load subcategories');
    }
  }

  void selectSubCategory(int subCategoryId) {
    selectedSubCategoryId.value = subCategoryId;
    subCategories.refresh();
  }
}
