import 'dart:developer';
import 'package:finall/feature/auth/business_logic_layer/auth_controller.dart';
import 'package:finall/common/widget/auth_scafold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Verifycode extends StatelessWidget {
  Verifycode({super.key, required this.phone, this.forVerifyAccount = 1});
  String otpCode = "";
  String phone;
  int forVerifyAccount = 1;
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: "Verify Your Phone number",
      title2: "Enter the 4-digit OTP sent to :+963 99554432",
      showBackButton: true,
      child: Column(
        spacing: 20,
        children: [
          OtpTextField(
            numberOfFields: 4,
            showFieldAsBox: true,
            fieldWidth: 60,
            fieldHeight: 50,
            margin: EdgeInsetsGeometry.only(left: 10, right: 10),
            cursorColor: Color(0xff7F7F7F),
            focusedBorderColor: Colors.black,

            onCodeChanged: (code) {
              // كل مرة المستخدم يكتب رقم
              log("Current: $code");
            },

            onSubmit: (verificationCode) {
              otpCode = verificationCode;
              log("Final OTP: $otpCode");
            },
          ),

          Row(
            children: [
              Text(
                "Didn't receive code ?",
                style: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff838383),
                ),
              ),

              OtpTimerButton(
                duration: 60, // عدد الثواني للعد التنازلي
                onPressed: () {
                  log("Resend OTP");
                  _authController.resendCode(phone: phone);
                },
                text: Text(
                  "Resend Code",
                  style: TextStyle(
                    color: Color(0xFFFF7A00), // البرتقالي الموجود بالصورة
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                buttonType: ButtonType.text_button, // زر نصّي بدون خلفية
              ),
            ],
          ),

          Obx(() {
            if (_authController.isLoading.value) {
              return CircularProgressIndicator();
            } else {
              return SizedBox(
                width:
                    MediaQuery.of(context).size.width *
                    0.84, // ياخد عرض الشاشة كامل
                height: 42,

                // نفس ارتفاع الزر بالصورة
                child: ElevatedButton(
                  onPressed: () {
                    if (otpCode.length == 4) {
                      log("Sending OTP: $otpCode"); // هون تبعتيه للسيرفر
                      _authController.verifyCode(
                        phone: phone,
                        code: int.parse(otpCode),
                        forVerifyAccount: forVerifyAccount,
                      );
                    } else {
                      log("OTP not complete");
                      Get.snackbar('خطأ', 'الرجاء إدخال رمز التحقق الكامل');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(
                      0xFF3E4E2C,
                    ), // الأخضر الغامق مثل الصورة
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: Text(
                    "Verify",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
