import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:finall/feature/Home/business_logic_layer/Home_controller.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  final HomeController controller = Get.put<HomeController>(HomeController());

  final List<String> icons = [
    'assets/svg/homeee.svg',
    'assets/svg/comm22.svg',
    'assets/svg/comm23.svg',
    'assets/svg/precenttt.svg',
    'assets/svg/comm24.svg',
  ];

  final List<String> labels = [
    'Home',
    'Entities',
    'Providers',
    'Offer',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CurvedNavigationBar(
        index: controller.currentIndex.value,
        height: 70,
        backgroundColor: Colors.transparent,
        color: const Color(0xFF7E8872),
        buttonBackgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 300),
        items: List.generate(icons.length, (index) {
          bool isSelected = controller.currentIndex.value == index;

          return CurvedNavigationBarItem(
            child: SvgPicture.asset(
              icons[index],
              width: index == 2 ? 35 : 28,
              height: index == 2 ? 35 : 28,
              color: isSelected ? const Color(0xFFFF6F00) : Colors.white,
            ),
            label: isSelected ? labels[index] : '',
            labelStyle: const TextStyle(color: Color(0xFFFF6F00), fontSize: 12),
          );
        }),
        onTap: controller.changeIndex,
      ),
    );
  }
}
