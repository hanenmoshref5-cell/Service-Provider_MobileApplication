import 'dart:developer';
import 'package:finall/common/widget/auth_scafold.dart';
import 'package:finall/feature/auth/presntation_layer/widget/CustomInputField.dart';
import 'package:finall/feature/auth/presntation_layer/widget/mainbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class Contactus extends StatelessWidget {
  Contactus({super.key});
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: "Contact Us",
      paddinglefttitel: 105,
      shownotificationbutton: true,
      paddingtopbackbutton: 100,
      showBackButton: true,
      notboldtitle: true,
      child: Form(
        key: _key,
        child: Column(
          spacing: 30,
          children: [
            CustomInputField(
              controller: firstnamecontroller,
              hint: "Mhamad",
              isName: true,
              prefix: SvgPicture.asset("assets/svg/user-profile-02.svg"),
            ),

            CustomInputField(
              controller: lastnamecontroller,
              hint: "Alshame",
              isName: true,
              prefix: SvgPicture.asset("assets/svg/user-profile-02.svg"),
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

            MainButton(
              text: "Send",
              onPressed: () {
                if (_key.currentState!.validate()) {
                  log("valid");
                } else {
                  log("notvalid");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
