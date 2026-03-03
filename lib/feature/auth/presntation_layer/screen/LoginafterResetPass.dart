import 'dart:developer';
import 'package:finall/common/widget/auth_scafold.dart';
import 'package:finall/feature/auth/business_logic_layer/auth_controller.dart';
import 'package:finall/feature/auth/presntation_layer/widget/CustomInputField.dart';
import 'package:finall/feature/auth/presntation_layer/widget/loginfooter.dart';
import 'package:finall/feature/auth/presntation_layer/widget/mainbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Loginafterresetpass extends StatelessWidget {
  Loginafterresetpass({super.key});
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  AuthController _authController = AuthController();
  
  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: "Log in to your Account",
      title2: "Welcome back! Log in to continue",
      showBackButton: true,
      NeverScroll: true,
      child: Form(
        key: _key,
        child: Column(
          spacing: 25,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 8.5,
              height: 79,
              padding: EdgeInsets.all(13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Color(0xffFCE1E2),
              ),
              child: Row(
                spacing: 15,
                children: [
                  SvgPicture.asset("assets/svg/Group 1000005023.svg"),
                  Expanded(
                    child: Text(
                      "Your Account is suspended please check with admin to resolve the issue.",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xffD85A5A),
                      ),
                    ),
                  ),
                ],
              ),
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

            CustomInputField(
              hint: "Password",
              controller: passcontroller,
              isPassword: true,
              prefix: SvgPicture.asset("assets/svg/lock (1) 1.svg"),
              suffix: SvgPicture.asset("assets/svg/Icon.svg"),
            ),

Obx(() {
              if (_authController.isLoading.value) {
                return const CircularProgressIndicator();
              } else {
                return SizedBox(
                  width: double.infinity,
                  child: MainButton(
                    text: "Log in",
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        log("valid");
                          _authController.login(
                            phonecontroller.text,
                            passcontroller.text,
                          );
                      } else {
                        log("notvalid");
                      }
                    },
                  ),
                );
              }
            }),

            LoginFooter(),
          ],
        ),
      ),
    );
  }
}
