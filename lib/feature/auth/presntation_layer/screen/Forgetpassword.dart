import 'dart:developer';
import 'package:finall/feature/auth/business_logic_layer/auth_controller.dart';
import 'package:get/get.dart';
import 'package:finall/common/widget/auth_scafold.dart';
import 'package:finall/feature/auth/presntation_layer/widget/CustomInputField.dart';
import 'package:finall/feature/auth/presntation_layer/widget/mainbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class Forgetpassword extends StatelessWidget {
  Forgetpassword({super.key});
  TextEditingController phonecontroller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: "Forget Password",
      title2: "Enter Your phone number to receive the Code",
      showBackButton: true,
      child: Column(
        spacing: 30,
        children: [
          Form(
            key: _key,
            child: CustomInputField(
              controller: phonecontroller,
              hint: " Write Your Phone Number",
              isPhone: true,
              prefix: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/svg/phone-call-01.svg"),
                  SvgPicture.asset("assets/svg/Frame 1597882148.svg"),
                ],
              ),
            ),
          ),

          Obx(() {
            if (_authController.isLoading.value) {
              return const CircularProgressIndicator();
            } else {
              return SizedBox(
                width: double.infinity,
                child: MainButton(
                  text: "Send Code ",
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      log("valid");
                      _authController.forgetPassword(
                        phone: phonecontroller.text,
                      );
                    } else {
                      log("notvalid");
                    }
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
