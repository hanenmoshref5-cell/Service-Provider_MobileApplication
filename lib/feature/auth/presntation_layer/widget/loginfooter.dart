import 'package:finall/feature/auth/presntation_layer/screen/Forgetpassword.dart';
import 'package:finall/feature/auth/presntation_layer/screen/SignUp.dart';
import 'package:finall/feature/becomeProvider/presentation_layer/Screen/BecomeProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 30,
      children: [
        Row(
          children: [
            Spacer(),
            TextButton(
              onPressed: () {
                Get.to(Forgetpassword());
              },
              child: Text(
                "Forgot Password?",
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Color(0xffFF8C33),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),

        Row(
          children: [
            Expanded(child: Divider(color: Color(0xffB0B0B0), thickness: 1)),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Or Enter as a Guest",
                style: TextStyle(color: Color(0xff717171), fontSize: 14),
              ),
            ),

            Expanded(child: Divider(color: Color(0xffB0B0B0), thickness: 1)),
          ],
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xffFF8C33), width: 1),
            ),
            elevation: 0, // بدون ظل مثل الـ Container
          ),
          onPressed: () {
            Get.to(Becomeprovider()); // ← غيريها للمكان اللي بدك تنتقلي له
          },
          child: Text(
            "Become a Provider",
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xffFF8C33),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an Account?",
              style: GoogleFonts.lato(color: Color(0xff7F7F7F), fontSize: 14),
            ),
            TextButton(
              onPressed: () {
                Get.to(Signup());
              },
              child: Text(
                "Click here",
                style: GoogleFonts.lato(color: Color(0xffFF8C33), fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
