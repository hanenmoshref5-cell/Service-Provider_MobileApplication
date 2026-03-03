import 'dart:developer';
import 'package:finall/common/widget/auth_scafold.dart';
import 'package:finall/feature/auth/business_logic_layer/auth_controller.dart';
import 'package:finall/feature/auth/presntation_layer/widget/CustomInputField.dart';
import 'package:finall/feature/auth/presntation_layer/widget/loginfooter.dart';
import 'package:finall/feature/auth/presntation_layer/widget/mainbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  Login({super.key});

  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  AuthController _authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: "Log in to your account",
      title2: "welcome back! login to continue",
      showBackButton: false,
      child: Form(
        key: _key,
        child: Column(
          spacing: 30,
          children: [
            CustomInputField(
              hint: " Write Your Phone Number",
              isPhone: true,
              controller: phonecontroller,
              prefix: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/svg/phone-call-01.svg"),
                  SizedBox(width: 6),
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

            // MainButton(
            //   text: "Log in",
            //   onPressed: () {
            //     if (_key.currentState!.validate()) {
            //       log("valid");
            //       Get.to(Splashscreen());
            //     } else {
            //       log("notvalid");
            //     }
            //   },
            // ),
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

            //           Obx(() {
            //   if (_authController.isLoading.value) {
            //     return const CircularProgressIndicator();
            //   } else {
            //     return SizedBox(
            //       width: double.infinity,
            //       child: ElevatedButton(
            //         onPressed: () {
            //           _authController.login(
            //             phonecontroller.text,
            //             passcontroller.text
            //             // emailController.text.trim(),
            //             // passwordController.text.trim(),
            //           );
            //         },
            //         child: const Text('login'),
            //       ),
            //     );
            //   }
            // }),
            LoginFooter(),
          ],
        ),
      ),
    );
  }
}
