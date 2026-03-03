import 'dart:io';
import 'package:finall/feature/auth/business_logic_layer/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppProfileForHome extends StatelessWidget {
  const AppProfileForHome({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final box = GetStorage();

    // استدعاء البيانات عند البناء
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authController.profileData.value == null) {
        authController.loadProfile();
      }
    });

    return Obx(() {
      final profile = authController.profileData.value;
      final displayName = profile?.getFullName() ?? 'User Name';

      // عرض الستيت والسيتي مع فاصلة بينهم
      String displayLocation;
      if (profile != null &&
          profile.city != null &&
          profile.city!.state != null &&
          profile.city!.state!.name.isNotEmpty &&
          profile.city!.name.isNotEmpty) {
        // State, City مثلاً "Riyadh, Riyadh"
        displayLocation = "${profile.city!.state!.name}, ${profile.city!.name}";
      } else if (profile != null &&
          profile.city != null &&
          profile.city!.name.isNotEmpty) {
        // فقط السيتي إذا ما في ستيت
        displayLocation = profile.city!.name;
      } else {
        // الـ fallback
        displayLocation = 'City, Location';
      }

      // محاولة جلب الصورة من الـ local storage أولاً
      final localImagePath = box.read('img') as String?;
      String displayImage;

      if (localImagePath != null && localImagePath.isNotEmpty) {
        // استخدام الصورة المحفوظة محلياً
        displayImage = localImagePath;
      } else if (profile != null && profile.image.isNotEmpty) {
        // استخدام الصورة من الـ profile
        displayImage = profile.image;
      } else {
        // استخدام الصورة الافتراضية
        displayImage = 'assets/img/pofile.png';
      }

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CircleAvatar(
              radius: 30,
              foregroundImage: displayImage.startsWith('http')
                  ? NetworkImage(displayImage)
                  : FileImage(File(displayImage)) as ImageProvider,
              backgroundColor: Colors.transparent,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  displayName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffE1EAFB),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  displayLocation,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffE1EAFB),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 100),
        ],
      );
    });
  }
}
