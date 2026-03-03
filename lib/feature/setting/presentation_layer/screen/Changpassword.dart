// import 'package:finall/common/widget/SuccessDialog.dart';
import 'package:finall/common/widget/auth_scafold.dart';
import 'package:finall/feature/auth/business_logic_layer/auth_controller.dart';
import 'package:finall/feature/auth/presntation_layer/widget/CustomInputField.dart';
import 'package:finall/feature/auth/presntation_layer/widget/mainbutton.dart';
import 'package:finall/feature/setting/presentation_layer/screen/Settingspage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


// ignore: must_be_immutable
class Changpassword extends StatelessWidget {
  Changpassword({super.key});

final GlobalKey<FormState> _key = GlobalKey<FormState>();
TextEditingController oldpasscontroller = TextEditingController();
TextEditingController newpasscontroller = TextEditingController();
TextEditingController confirmpasscontroller = TextEditingController();
final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(title: "Change Password", showBackButton:true,title2: "Create your new password to access your account" ,child: Form(
      key: _key,
      child: Column(
      spacing: 30,
      children: [
        CustomInputField(
                hint: "Old Password...",
                controller: oldpasscontroller,
                isPassword: true,
                prefix:  SvgPicture.asset("assets/svg/lock (1) 1.svg"),
                suffix:  SvgPicture.asset("assets/svg/Icon.svg"),
              ),
      
        CustomInputField(
                hint: "New Password...",
                controller: newpasscontroller,
                isPassword: true,
                prefix:  SvgPicture.asset("assets/svg/lock (1) 1.svg"),
                suffix:  SvgPicture.asset("assets/svg/Icon.svg"),
              ),
      
                  CustomInputField(
              hint: " Confirm Password",
              controller: confirmpasscontroller,
              compareWith: newpasscontroller,
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
                    text: "Reset Password",
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        log("valid");
                        Future.delayed(Duration(seconds: 1), () {
                          _authController.changpassword(
                            oldPassword:oldpasscontroller.text ,
newPassword:newpasscontroller.text ,
newPasswordConfirmation:confirmpasscontroller.text ,
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
                                                      .changSuccess
                                                      .value) {
                                                    Get.to(
                                                    Settingspage(),
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







//         MainButton(
//                   text: "Reset Password ",
//                   onPressed: () {
//                     if (_key.currentState!.validate()) {
//                       log("valid");

// // showDialog(
// //   context: context,
// //   barrierDismissible: false,
// //   builder: (context) {
// //     return SuccessDialog(
// //       title: "Password Changed successfully",
// //       message: "Password Change complete! You can now log in with your new password.",
// //       onPressed: () {
// //         Navigator.pop(context);
// //       },
// //     );
// //   },
// // );

//                           showDialog(
//                           context: context,
//                           barrierDismissible: false,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               backgroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               content: Padding(
//                                 padding: const EdgeInsets.all(9.0),
//                                 child: SizedBox(
//                                   width: 343,
//                                   height: 340,
//                                   child: Column(
//                                     spacing: 10,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Obx(() {
//                                         return _authController.isLoading.value
//                                             ? SizedBox(
//                                                 width: 100,
//                                                 height: 100,
//                                                 child:
//                                                     CircularProgressIndicator(
//                                                       color: Colors.orange,
//                                                       strokeWidth: 4,
//                                                     ),
//                                               )
//                                             : SizedBox(width: 100, height: 100);
//                                       }),
//                                       SizedBox(height: 20),
//                                       Obx(() {
//                                         if (_authController.isLoading.value) {
//                                           return Text(
//                                             "waiting...",
//                                             style: GoogleFonts.lato(
//                                               fontSize: 17,
//                                               fontWeight: FontWeight.w500,
//                                               color: Colors.orange,
//                                             ),
//                                           );
//                                         } else {
//                                           return Column(
//                                             children: [
//                                               Text(
//                                                 "Password reset succesfuly",
//                                                 style: GoogleFonts.lato(
//                                                   fontSize: 17,
//                                                   fontWeight: FontWeight.w500,
//                                                   color: Colors.orange,
//                                                 ),
//                                               ),
//                                               SizedBox(height: 10),
//                                               Text(
//                                                 "Password reset complete! You can now log in with your new password.",
//                                                 style: GoogleFonts.lato(
//                                                   fontSize: 13,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Color(0xff767676),
//                                                 ),
//                                               ),
//                                             ],
//                                           );
//                                         }
//                                       }),
//                                       SizedBox(height: 20),
//                                       Obx(() {
//                                         return ElevatedButton(
//                                           onPressed:
//                                               _authController.isLoading.value
//                                               ? null
//                                               : () {
//                                                   Navigator.pop(context);
//                                                   if (_authController
//                                                       .changSuccess
//                                                       .value) {
//                                                     Get.to(
//                                                     Settingspage(),
//                                                     );
//                                                   }
//                                                 },
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor:
//                                                 _authController.isLoading.value
//                                                 ? Colors.grey
//                                                 : const Color(0xFFE86500),
//                                             minimumSize: const Size(244, 42),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(4),
//                                             ),
//                                           ),
//                                           child: Text(
//                                             "Ok",
//                                             style: GoogleFonts.cairo(
//                                               color: Colors.white,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                         );
//                                       }),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         );


//                     } else {
//                       log("notvalid");
//                     }
//                   },
//                 ),
      
      ],
      ),
    ));
  }
}
