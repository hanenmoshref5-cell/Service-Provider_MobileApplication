import 'package:finall/common/widget/BottomNavbar.dart';
import 'package:finall/feature/Entities/presentation_layer/screens/entitiespage.dart';
import 'package:finall/feature/Offers/presentation_layer/screens/Offerspage.dart';
import 'package:finall/feature/Home/business_logic_layer/Home_controller.dart';
import 'package:finall/feature/home/presentation_layer/screens/homepage.dart';
import 'package:finall/feature/Providers/presentation_layer/screens/providerspage.dart';
import 'package:finall/feature/setting/presentation_layer/screen/Settingspage.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class HomeMaster extends StatelessWidget {
  HomeMaster({super.key});

  final HomeController controller = Get.put(HomeController());

  final List<Widget> pages = [
    Homepage(),
    Entitiespage(),
    Providerspage(),
    Offerspage(),
    Settingspage(),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
