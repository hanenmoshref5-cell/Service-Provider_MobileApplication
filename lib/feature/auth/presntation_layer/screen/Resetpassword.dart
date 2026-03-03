import 'dart:developer';
import 'package:finall/common/widget/auth_scafold.dart';
import 'package:finall/feature/auth/business_logic_layer/auth_controller.dart';
import 'package:finall/feature/auth/presntation_layer/screen/LoginafterResetPass.dart';
import 'package:finall/feature/auth/presntation_layer/widget/CustomInputField.dart';
import 'package:finall/feature/auth/presntation_layer/widget/mainbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Resetpassword extends StatefulWidget {
  Resetpassword({super.key, required this.phone, required this.code});
  String phone;
  int code;

  @override
  State<Resetpassword> createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  TextEditingController passcontroller = TextEditingController();
  TextEditingController confirmpasscontroller = TextEditingController();
  final AuthController _authController = AuthController();

  @override
  void initState() {
    super.initState();
    log("RESET PASSWORD RECEIVED CODE: ${widget.code}");
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: "Reset Password",
      title2: "Create Your new password to access Your account",
      showBackButton: true,
      child: Form(
        key: _key,
        child: Column(
          spacing: 25,
          children: [
            CustomInputField(
              hint: "Enter password",
              isPassword: true,
              controller: passcontroller,
              prefix: SvgPicture.asset("assets/svg/lock (1) 1.svg"),
            ),

            CustomInputField(
              hint: "Confirm password...",
              isPassword: true,
              controller: confirmpasscontroller,
              compareWith: passcontroller,
              prefix: SvgPicture.asset("assets/svg/lock (1) 1.svg"),
            ),

            Obx(() {
              if (_authController.isLoading.value) {
                return const CircularProgressIndicator();
              } else {
                return SizedBox(
                  width: double.infinity,
                  child: MainButton(
                    text: "Reset Password",
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        log("valid");
                        
                        _authController.resendCode(phone: widget.phone);

                        
                        Future.delayed(Duration(seconds: 1), () {
                          _authController.resetPassword(
                            phone: widget.phone,
                            code: widget.code,
                            password: passcontroller.text,
                            passwordConfirmation: confirmpasscontroller.text,
                          );
                        });

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: SizedBox(
                                  width: 343,
                                  height: 340,
                                  child: Column(
                                    spacing: 10,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Obx(() {
                                        return _authController.isLoading.value
                                            ? SizedBox(
                                                width: 100,
                                                height: 100,
                                                child:
                                                    CircularProgressIndicator(
                                                      color: Colors.orange,
                                                      strokeWidth: 4,
                                                    ),
                                              )
                                            : SizedBox(width: 100, height: 100);
                                      }),
                                      SizedBox(height: 20),
                                      Obx(() {
                                        if (_authController.isLoading.value) {
                                          return Text(
                                            "waiting...",
                                            style: GoogleFonts.lato(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.orange,
                                            ),
                                          );
                                        } else {
                                          return Column(
                                            children: [
                                              Text(
                                                "Password reset succesfuly",
                                                style: GoogleFonts.lato(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Password reset complete! You can now log in with your new password.",
                                                style: GoogleFonts.lato(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff767676),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      }),
                                      SizedBox(height: 20),
                                      Obx(() {
                                        return ElevatedButton(
                                          onPressed:
                                              _authController.isLoading.value
                                              ? null
                                              : () {
                                                  Navigator.pop(context);
                                                  if (_authController
                                                      .resetSuccess
                                                      .value) {
                                                    Get.to(
                                                      Loginafterresetpass(),
                                                    );
                                                  }
                                                },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                _authController.isLoading.value
                                                ? Colors.grey
                                                : const Color(0xFFE86500),
                                            minimumSize: const Size(244, 42),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                          child: Text(
                                            "Ok",
                                            style: GoogleFonts.cairo(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
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
      ),
    );
  }
}
