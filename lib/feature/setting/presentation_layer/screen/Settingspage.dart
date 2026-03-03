import 'package:finall/common/widget/auth_scafold.dart';
// import 'package:finall/feature/auth/presntation_layer/screen/login.dart';
import 'package:finall/feature/auth/business_logic_layer/auth_controller.dart';
import 'package:finall/feature/auth/presntation_layer/widget/mainbutton.dart';
import 'package:finall/feature/becomeProvider/presentation_layer/Screen/BecomeProvider.dart';
import 'package:finall/feature/setting/presentation_layer/screen/changpassword.dart';
import 'package:finall/feature/setting/presentation_layer/screen/contactUs.dart';
import 'package:finall/feature/setting/presentation_layer/screen/privacypolicy.dart';
import 'package:finall/feature/setting/presentation_layer/widget/AboutUsBottomSheetWidget.dart';
import 'package:finall/feature/setting/presentation_layer/widget/LanguageBottomSheetWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';
import 'package:get/get.dart';

class Settingspage extends StatelessWidget {
  const Settingspage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = AuthController();

    return AuthScaffold(
      title: "Setting Page",
      showBackButton: false,
      paddinglefttitel: MediaQuery.sizeOf(context).width * 0.28,
      paddingtopbackbutton: 100,
      shownotificationbutton: true,
      showProfileInTopContainer: true,
      notboldtitle: true,
      NeverScroll: true,
      child: Column(
        children: [
          SizedBox(height: 140),

          SizedBox(
            height: 290,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "About The App",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      color: Color(0xff5A5A5A),
                    ),
                  ),

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: SvgPicture.asset('assets/svg/book.svg'),
                    title: Text(
                      "Privacy Policy",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff5A5A5A),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      log("message");
                      Get.to(Privacypolicy());
                    },
                  ),

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: SvgPicture.asset('assets/svg/provedor.svg'),
                    title: Text(
                      "Become A Provider",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff5A5A5A),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      Get.to(Becomeprovider());
                    },
                  ),

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: SvgPicture.asset('assets/svg/smaa3a.svg'),
                    title: Text(
                      "Contact Us",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff5A5A5A),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      Get.to(Contactus());
                    },
                  ),

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: SvgPicture.asset('assets/svg/warning.svg'),
                    title: Text(
                      "About Us",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff5A5A5A),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (_) {
                          return AboutUsBottomSheetWidget(
                            onClose: () => Navigator.pop(context),
                          );
                        },
                      );
                    },
                  ),

                  Divider(),

                  Text(
                    "Settings",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      color: Color(0xff5A5A5A),
                    ),
                  ),

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: SvgPicture.asset('assets/svg/lang.svg'),
                    title: Text(
                      "Language",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff5A5A5A),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (_) {
                          return LanguageBottomSheetWidget(
                            onClose: () => Navigator.pop(context),
                            onSelect: (lang) {
                              print("Selected: $lang");
                            },
                          );
                        },
                      );
                    },
                  ),

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: SvgPicture.asset('assets/svg/lock.svg'),
                    title: Text(
                      "Change Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff5A5A5A),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      Get.to(Changpassword());
                    },
                  ),

                  MainButton(
                    text: "Log out",
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: EdgeInsets.zero,
                            content: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: SizedBox(
                                    width: 343,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 10),

                                        Text(
                                          "Are you sure you want to log out?",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.lato(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xffE86500),
                                          ),
                                        ),

                                        const SizedBox(height: 25),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // زر Cancel
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: OutlinedButton.styleFrom(
                                                side: const BorderSide(
                                                  color: Color(0xffE86500),
                                                  width: 1.5,
                                                ),
                                                minimumSize: const Size(
                                                  120,
                                                  42,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                ),
                                              ),
                                              child: Text(
                                                "Cancel",
                                                style: GoogleFonts.cairo(
                                                  color: Color(0xffE86500),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),

                                            // زر Confirm
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                authController.logout();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(
                                                  0xff3E4E2C,
                                                ),
                                                minimumSize: const Size(
                                                  120,
                                                  42,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                ),
                                              ),
                                              child: Text(
                                                "Confirm",
                                                style: GoogleFonts.cairo(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // زر الإغلاق (X)
                                Positioned(
                                  top: 2,
                                  right: 5,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      size: 25,
                                      color: Color.fromARGB(255, 115, 117, 117),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
