import 'package:finall/feature/Home/business_logic_layer/Home_controller.dart';
import 'package:finall/feature/Home/presentation_layer/widgets/homeAppBar.dart';
import 'package:finall/feature/Home/presentation_layer/widgets/bestOffers.dart';
import 'package:finall/feature/Providers/presentation_layer/screens/providerspage.dart';
import 'package:finall/feature/categories/business_logic_layer/categorycontroller.dart';
import 'package:finall/feature/categories/presentation_layer/widgets/categoriesRow.dart';
import 'package:finall/feature/Home/presentation_layer/widgets/ministryCard.dart';
import 'package:finall/feature/Home/presentation_layer/widgets/offerSlider.dart';
import 'package:finall/feature/Home/presentation_layer/widgets/serviceProviders.dart';
import 'package:finall/feature/categories/presentation_layer/screens/categoriespage.dart';
import 'package:finall/common/widgets/searchBar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  final HomeController controller = Get.find<HomeController>();
  final Categoriescontroller categoriescontroller = Get.put(
    Categoriescontroller(),
  );
  final HomeSliderController homeSliderController = Get.put(
    HomeSliderController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 13,

          children: [
            Homeappbar(),
            Searchbarr(),
            Offerslider(),
            _sectionHeader(
              title: 'Categories',
              onTap: () {
                Get.to(Categoriespage());
              },
            ),
            Categoriesrow(categories: categoriescontroller.categories),
            Ministrycard(),
            Bestoffers(),
            _sectionHeader(
              title: 'Service Providers',
              onTap: () {
                Get.to(Providerspage());
              },
            ),
            ServiceProviders(),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader({required String title, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color(0xff2C371F),
            ),
          ),
          TextButton(
            onPressed: onTap,
            child: const Text(
              'Show All',
              style: TextStyle(color: Color(0xFFFF6F00)),
            ),
          ),
        ],
      ),
    );
  }
}
