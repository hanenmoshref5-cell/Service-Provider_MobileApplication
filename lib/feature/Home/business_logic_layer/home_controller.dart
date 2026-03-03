import 'package:dio/dio.dart';
import 'package:finall/feature/Home/data_layer/models/classes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  final int sliderCount = 3;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}

class LocaleController extends GetxController {
  Rx<Locale> locale = Locale('en').obs;
}

class HomeSliderController extends GetxController {
  RxInt currentIndex = 0.obs;

  final int sliderCount = 3;

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  final Dio dio = Dio(BaseOptions(baseUrl: 'http://94.72.98.154:8085/api/'));

  var isLoading = false.obs;
  var slider = <SliderItem>[].obs;

  var searchText = ''.obs;

  Future<void> fetchslider({String search = ''}) async {
    try {
      isLoading.value = true;

      final response = await dio.get(
        'sliders',
        queryParameters: search.isNotEmpty ? {'search': search} : null,
      );

      slider.value = SliderItem.fromJsonList(response.data['data']);
    } catch (e) {
      print('Error fetching slider: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchChanged(String value) {
    searchText.value = value;
    fetchslider(search: value);
  }

  @override
  void onInit() {
    fetchslider();
    super.onInit();
  }
}

class CategoriesController extends GetxController {
  RxInt selectedIndex = 0.obs;

  final RxList<CategoryModel> categories = [
    CategoryModel(
      title: 'Restaurants',
      icon: 'assets/icons/badge-percent 2.svg',
    ),
    CategoryModel(
      title: 'Groceries',
      icon: 'assets/icons/car-mechanic (1) 2.svg',
    ),
    CategoryModel(
      title: 'Doctors',
      icon: 'assets/icons/car-mechanic (1) 2.svg',
    ),
    CategoryModel(title: 'Cars', icon: 'assets/icons/car-mechanic (1) 2.svg'),
    CategoryModel(title: 'Cars', icon: 'assets/icons/car-mechanic (1) 2.svg'),
    CategoryModel(title: 'Doctors', icon: 'assets/icons/badge-percent 2.svg'),
  ].obs;

  void selectCategory(int index) {
    selectedIndex.value = index;
    categories.refresh();
  }
}

class CategoryModel {
  final String title;
  final String icon;

  CategoryModel({required this.title, required this.icon});
}

// // class ServiceProviderModel {
// //   final String name;
// //   final String image;
// //   final String views;

// //   ServiceProviderModel({
// //     required this.name,
// //     required this.image,
// //     required this.views,
//   // });
// }
