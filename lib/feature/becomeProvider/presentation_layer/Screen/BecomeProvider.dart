import 'dart:developer';

import 'package:finall/common/widget/auth_scafold.dart';
import 'package:finall/feature/auth/business_logic_layer/auth_controller.dart';
import 'package:finall/feature/auth/presntation_layer/widget/CustomInputField.dart';
import 'package:finall/feature/auth/presntation_layer/widget/mainbutton.dart';
import 'package:finall/feature/becomeProvider/presentation_layer/widget/importimg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Becomeprovider extends StatelessWidget {
  Becomeprovider({super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController whatsupcontroller = TextEditingController();
  TextEditingController instacontroller = TextEditingController();
  TextEditingController facebookcontroller = TextEditingController();
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedState;
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: "Become A Provider",
      showBackButton: true,
      title2: "Fill This Form To Send A Request",
      NeverScroll: true,
      child: Form(
        key: _key,
        child: Column(
          spacing: 25,
          children: [
            ImagePickerBox(),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  flex: 1,
                  child: CustomInputField(
                    controller: firstnamecontroller,
                    hint: "Provider Name",
                    isName: true,
                    prefix: SvgPicture.asset("assets/svg/user-profile-02.svg"),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: CustomInputField(
                    controller: lastnamecontroller,
                    hint: "Shop Name",
                    isName: true,
                    prefix: SvgPicture.asset("assets/svg/store-alt 1.svg"),
                  ),
                ),
              ],
            ),

            Container(
              height: 99,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              child: Row(
                children: [
                  SvgPicture.asset("assets/svg/docc.svg"),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: descriptioncontroller,
                      decoration: InputDecoration(
                        hintText: "Description...",
                        hintStyle: TextStyle(
                          color: const Color.fromARGB(255, 97, 96, 96),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    value: selectedCategory,
                    decoration: InputDecoration(
                      hint: Text(
                        "Category",
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          color: Color(0xff717171),
                        ),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          "assets/svg/category 1.svg",
                          width: 18,
                          height: 18,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: SvgPicture.asset(
                          "assets/svg/chevron-down-s.svg",
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: "Cars", child: Text("Cars")),
                      DropdownMenuItem(
                        value: "Computer",
                        child: Text("Computer"),
                      ),
                      DropdownMenuItem(
                        value: "teacher",
                        child: Text("Teachering"),
                      ),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select option";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      selectedCategory = value;
                    },
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    value: selectedSubCategory,
                    decoration: InputDecoration(
                      hint: Text(
                        "Sub Cate",
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          color: Color(0xff717171),
                        ),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          "assets/svg/category 1.svg",
                          width: 18,
                          height: 18,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: SvgPicture.asset(
                          "assets/svg/chevron-down-s.svg",
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: "12", child: Text("syria")),
                      DropdownMenuItem(value: "13", child: Text("clean")),
                      DropdownMenuItem(
                        value: "14",
                        child: Text("classification"),
                      ),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select option";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      selectedSubCategory = value;
                    },
                  ),
                ),
              ],
            ),
            CustomInputField(
              hint: " Write Your Phone Number",
              controller: phonecontroller,
              isPhone: true,
              prefix: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/svg/phone-call-01.svg"),
                  SvgPicture.asset("assets/svg/Frame 1597882148.svg"),
                ],
              ),
            ),

            Row(
              spacing: 10,
              children: [
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    value: selectedState,
                    decoration: InputDecoration(
                      hint: Text(
                        "state",
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          color: Color(0xff717171),
                        ),
                      ),

                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset("assets/svg/State4.svg"),
                      ),

                      // الأيقونة بالنهاية
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: SvgPicture.asset(
                          "assets/svg/chevron-down-s.svg",
                        ),
                      ),

                      // البوردر
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: "syria", child: Text("syria")),
                      DropdownMenuItem(
                        value: "america",
                        child: Text("america"),
                      ),
                      DropdownMenuItem(value: "dubai", child: Text("dubai")),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select option";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      selectedState = value;
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    value: selectedCity,
                    decoration: InputDecoration(
                      hint: Text(
                        "City",
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          color: Color(0xff717171),
                        ),
                      ),

                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset("assets/svg/building 1.svg"),
                      ),

                      // الأيقونة بالنهاية
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: SvgPicture.asset(
                          "assets/svg/chevron-down-s.svg",
                        ),
                      ),

                      // البوردر
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: "1", child: Text("syria")),
                      DropdownMenuItem(value: "2", child: Text("america")),
                      DropdownMenuItem(value: "3", child: Text("dubai")),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select option";
                      }
                      return null;
                    },

                    onChanged: (value) {
                      selectedCity = value;
                    },
                  ),
                ),
              ],
            ),

            CustomInputField(
              hint: " Write Your WhatsApp Number",
              controller: whatsupcontroller,
              isPhone: true,
              prefix: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/svg/WA_Logo.svg"),
                  SvgPicture.asset("assets/svg/Frame 1597882148.svg"),
                ],
              ),
            ),

            CustomInputField(
              hint: " Write Your Instagram link",
              controller: instacontroller,
              isName: true,
              prefix: Row(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/svg/insta.svg"),
                  SvgPicture.asset("assets/svg/Line 49.svg"),
                ],
              ),
            ),

            CustomInputField(
              hint: " Write Your facebook link",
              controller: facebookcontroller,
              isName: true,
              prefix: Row(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/svg/facebook.svg"),
                  SvgPicture.asset("assets/svg/Line 49.svg"),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Obx(() {
                return MainButton(
                  text: _authController.isLoading.value
                      ? "waiting...."
                      : "Sign Up ",
                  onPressed: () {
                    if (_authController.isLoading.value) return;

                    if (_key.currentState!.validate()) {
                      log("valid");

                      // بناء البيانات - حد أقصى 3 social links
                      List<Map<String, dynamic>> socialLinks = [];

                      // إضافة رقم الهاتف إذا كان موجود (type: 3 = PHONE)
                      if (phonecontroller.text.isNotEmpty) {
                        socialLinks.add({
                          "type": 3, // PHONE
                          "value": phonecontroller.text,
                        });
                      }

                      // إضافة Instagram إذا كان موجود (type: 2 = INSTAGRAM)
                      if (instacontroller.text.isNotEmpty &&
                          socialLinks.length < 3) {
                        socialLinks.add({
                          "type": 2, // INSTAGRAM
                          "value": instacontroller.text,
                        });
                      }

                      // إضافة Facebook إذا كان موجود (type: 1 = FACEBOOK)
                      if (facebookcontroller.text.isNotEmpty &&
                          socialLinks.length < 3) {
                        socialLinks.add({
                          "type": 1, // FACEBOOK
                          "value": facebookcontroller.text,
                        });
                      }

                      // ملاحظة: WhatsApp ما في type خاص فيه في الـ API
                      // استخدم فقط: Phone (3), Instagram (2), Facebook (1)

                      log(
                        "SOCIAL LINKS (${socialLinks.length} items): $socialLinks",
                      );

                      // استدعاء الـ controller
                      _authController.becomeProvider(
                        providerName: firstnamecontroller.text,
                        shopName: {
                          "ar": lastnamecontroller.text,
                          "en": lastnamecontroller.text,
                        },
                        subCategoryId: int.parse(selectedSubCategory!),
                        description: {
                          "ar": descriptioncontroller.text,
                          "en": descriptioncontroller.text,
                        },
                        cityId: int.parse(selectedCity!),
                        socialLinks: socialLinks,
                      );
                    } else {
                      log("notvalid");
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
