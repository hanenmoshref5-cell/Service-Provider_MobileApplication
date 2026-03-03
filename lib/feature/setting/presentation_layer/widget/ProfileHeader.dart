import 'dart:io';
import 'package:finall/feature/auth/business_logic_layer/auth_controller.dart';
import 'package:finall/feature/setting/presentation_layer/screen/EditProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileHeader extends StatelessWidget {
  final String? imagePath;
  final String? name;
  final String? location;

  const ProfileHeader({super.key, this.imagePath, this.name, this.location});

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

    return SizedBox(
      // padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(() {
        final profile = authController.profileData.value;
        final displayName = profile?.getFullName() ?? name ?? 'User Name';
        
        // عرض الستيت والسيتي مع فاصلة بينهم
        String displayLocation;
        if (profile != null && 
            profile.city != null && 
            profile.city!.state != null &&
            profile.city!.state!.name.isNotEmpty &&
            profile.city!.name.isNotEmpty) {
          // State, City مثلاً "Riyadh, Riyadh"
          displayLocation = "${profile.city!.state!.name}, ${profile.city!.name}";
        } else if (profile != null && profile.city != null && profile.city!.name.isNotEmpty) {
          // فقط السيتي إذا ما في ستيت
          displayLocation = profile.city!.name;
        } else {
          // الـ fallback
          displayLocation = location ?? 'City, Location';
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
          displayImage = imagePath ?? "assets/img/pofile.png";
        }

        return Column(
          children: [
            // صورة البروفايل
            CircleAvatar(
              radius: 50,
              foregroundImage: displayImage.startsWith('http')
                  ? NetworkImage(displayImage)
                  : FileImage(File(displayImage)) as ImageProvider,
              backgroundColor: Colors.transparent,
            ),

            const SizedBox(height: 8),

            Text(
              displayName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 4),

            Text(
              displayLocation,
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 79, 78, 78),
              ),
            ),
            const SizedBox(height: 13),

            ElevatedButton(
              onPressed: () {
                Get.to(Editprofile());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size(161, 42),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                  side: const BorderSide(color: Color(0xffFF8C33), width: 1),
                ),
              ),
              child: Text(
                "Edit Profile",
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffFF8C33),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
