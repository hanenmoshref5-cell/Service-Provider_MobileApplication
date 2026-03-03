import 'dart:developer';
import 'package:finall/feature/auth/business_logic_layer/auth_controller.dart';
import 'package:get/get.dart';
import 'package:finall/common/widget/auth_scafold.dart';
import 'package:finall/feature/auth/presntation_layer/widget/CustomInputField.dart';
import 'package:finall/feature/auth/presntation_layer/widget/mainbutton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class Signup extends StatefulWidget {
  Signup({super.key});
  bool ischecked = false;
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isChecked = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController confirmpasscontroller = TextEditingController();
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  String? selectedCity;
  int? cityId;
  final AuthController _authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: "Sign up to create account",
      showBackButton: true,
      NeverScroll: true,
      child: Form(
        key: _key,
        child: Column(
          spacing: 26,
          children: [
            Row(
              spacing: 10,
              children: [
                Expanded(
                  flex: 1,
                  child: CustomInputField(
                    controller: firstnamecontroller,
                    hint: "First Name",
                    isName: true,
                    prefix: SvgPicture.asset("assets/svg/user-profile-02.svg"),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: CustomInputField(
                    controller: lastnamecontroller,
                    hint: "Last Name",
                    isName: true,
                    prefix: SvgPicture.asset("assets/svg/user-profile-02.svg"),
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
                    onChanged: (value) {},
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
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
                      DropdownMenuItem(value: "1", child: Text("city 1")),
                      DropdownMenuItem(value: "2", child: Text("city 2")),
                      DropdownMenuItem(value: "3", child: Text("city 3")),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select city";
                      }
                      return null;
                    },

                    onChanged: (value) {
                      setState(() {
                        selectedCity = value;
                        cityId = int.parse(value ?? "1");
                      });
                    },
                  ),
                ),
              ],
            ),

            CustomInputField(
              hint: "Password",
              controller: passcontroller,
              isPassword: true,
              prefix: SvgPicture.asset("assets/svg/lock (1) 1.svg"),
              suffix: SvgPicture.asset("assets/svg/Icon.svg"),
            ),

            CustomInputField(
              hint: " Confirm Password",
              controller: confirmpasscontroller,
              compareWith: passcontroller,
              isPassword: true,
              prefix: SvgPicture.asset("assets/svg/lock (1) 1.svg"),
              suffix: SvgPicture.asset("assets/svg/Icon.svg"),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isChecked
                    ? SizedBox()
                    : Text("*", style: TextStyle(color: Colors.red)),
                Checkbox(
                  value: isChecked,
                  onChanged: (v) {
                    setState(() {
                      isChecked = v!;
                    });
                  },
                  activeColor: Colors.green, // اللون لما يكون ON
                  checkColor: Colors.white, // لون علامة الصح
                ),

                const Text("I agree with "),
                Text(
                  "terms & policies",
                  style: TextStyle(
                    color: Colors.orange.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            // ------------------- SIGN UP BUTTON -------------------
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Obx(() {
                if (_authController.isLoading.value) {
                  return const CircularProgressIndicator();
                } else {
                  return SizedBox(
                    width: double.infinity,
                    child: MainButton(
                      text: "Sign Up ",
                      onPressed: () {
                        if (_key.currentState!.validate() && isChecked) {
                          log("valid");
                          _authController.signup(
                            firstName: firstnamecontroller.text,
                            lastName: lastnamecontroller.text,
                            phone: phonecontroller.text,
                            password: passcontroller.text,
                            passwordConfirmation: confirmpasscontroller.text,
                            cityId: cityId ?? 1,
                          );
                        } else {
                          log("notvalid");
                        }
                      },
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );

    //     return Scaffold(
    //       body: SizedBox(
    //         height: MediaQuery.of(context).size.height,
    //         child: Stack(
    //           children: [
    //             Container(
    //               width: MediaQuery.of(context).size.width,
    //               height: 254,
    //               decoration: BoxDecoration(
    //                 image: DecorationImage(
    //                   image: AssetImage('assets/img/backgroundouth.png'),
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //             ),

    //             Positioned(
    //               top: 110,
    //               left: 20,
    //               child: Text(
    //                 "Sign up to create account",
    //                 style: GoogleFonts.cairo(
    //                   color: Colors.white,
    //                   fontSize: 28,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //             ),
    //             Positioned(
    //               left: 20,
    //               top: 60,
    //               child: InkWell(
    //                 onTap: () {
    //                   print('backeeeee');
    //                 },
    //                 child: SvgPicture.asset("assets/svg/Frame 1261154538.svg"),
    //               ),
    //             ),
    //             Positioned(
    //               top: 200,
    //               bottom: 0,
    //               child: Container(
    //                 width: MediaQuery.of(context).size.width,
    //                 padding: const EdgeInsets.only(top: 43, left: 18, right: 18),
    //                 decoration: const BoxDecoration(
    //                   color: Colors.white,
    //                   borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
    //                 ),

    //                 child: SingleChildScrollView(
    //                   child: Column(
    //                     spacing: 26,
    //                     children: [
    //                       Row(
    //                         spacing: 10,
    //                         children: [
    //                           Expanded(
    //                             flex: 1,
    //                             child: CustomInputField(
    //                             hint: "First Name",
    //                             isName: true,
    //                             prefix: SvgPicture.asset("assets/svg/user-profile-02.svg"),
    //                             )
    //                           ),

    //                           Expanded(
    //                             flex: 1,
    //                             child: CustomInputField(
    //   hint: "Last Name",
    //   isName: true,
    //   prefix: SvgPicture.asset("assets/svg/user-profile-02.svg"),
    // )
    //                           ),
    //                         ],
    //                       ),

    // CustomInputField(
    //   hint: " Write Your Phone Number",
    //   isPhone: true,
    //   prefix: Row(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       SvgPicture.asset("assets/svg/phone-call-01.svg"),
    //       SvgPicture.asset("assets/svg/Frame 1597882148.svg"),
    //     ],
    //   ),
    // ),

    //                       Row(
    //                         spacing: 10,
    //                         children: [

    // Expanded(
    //   flex: 1,
    //   child:DropdownButtonFormField<String>(
    //     decoration:InputDecoration(
    //       hint: Text("state",style: GoogleFonts.lato(
    //                                   fontSize: 12,
    //                                   color: Color(0xff717171),
    //                                 ),),

    //       prefixIcon: Padding(
    //         padding: const EdgeInsets.all(12.0),
    //         child: SvgPicture.asset(
    //           "assets/svg/State4.svg",
    //         ),
    //       ),

    //           // الأيقونة بالنهاية
    //       suffixIcon: Padding(
    //         padding: const EdgeInsets.all(1.0),
    //         child: SvgPicture.asset(
    //           "assets/svg/chevron-down-s.svg",
    //         ),
    //       ),

    // // البوردر
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(5),
    //       ),

    //     ),
    //     items:const[
    //       DropdownMenuItem(value: "syria",child:Text("syria"),),
    //       DropdownMenuItem(value: "america",child:Text("america"),),
    //       DropdownMenuItem(value: "dubai",child:Text("dubai"),),
    //     ],
    //    onChanged: (value) {
    //    },) ),
    //    Expanded(
    //   flex: 1,
    //   child:DropdownButtonFormField<String>(
    //     decoration:InputDecoration(
    //       hint: Text("City",style: GoogleFonts.lato(
    //                                   fontSize: 12,
    //                                   color: Color(0xff717171),
    //                                 ),),

    //       prefixIcon: Padding(
    //         padding: const EdgeInsets.all(12.0),
    //         child: SvgPicture.asset(
    //           "assets/svg/building 1.svg",
    //         ),
    //       ),

    //           // الأيقونة بالنهاية
    //       suffixIcon: Padding(
    //         padding: const EdgeInsets.all(1.0),
    //         child: SvgPicture.asset(
    //           "assets/svg/chevron-down-s.svg",
    //         ),
    //       ),

    // // البوردر
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(5),
    //       ),

    //     ),
    //     items:const[
    //       DropdownMenuItem(value: "syria",child:Text("syria"),),
    //       DropdownMenuItem(value: "america",child:Text("america"),),
    //       DropdownMenuItem(value: "dubai",child:Text("dubai"),),
    //     ],
    //   onChanged: (value) {
    //   },) ),

    //                         ],
    //                       ),

    //                       CustomInputField(
    //   hint: "Password",
    //   isPassword: true,
    //   prefix: SvgPicture.asset("assets/svg/lock (1) 1.svg"),
    //   suffix: SvgPicture.asset("assets/svg/Icon.svg"),
    // ),

    //   CustomInputField(
    //   hint: " Confirm Password",
    //   isPassword: true,
    //   prefix: SvgPicture.asset("assets/svg/lock (1) 1.svg"),
    //   suffix: SvgPicture.asset("assets/svg/Icon.svg"),
    // ),

    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: [
    //                           Checkbox(
    //                             value: isChecked,
    //                             onChanged: (v) {
    //                               setState(() {
    //                                 isChecked = v!;
    //                               });
    //                             },
    //                             activeColor: Colors.green, // اللون لما يكون ON
    //                             checkColor: Colors.white, // لون علامة الصح
    //                           ),

    //                           const Text("I agree with "),
    //                           Text(
    //                             "terms & policies",
    //                             style: TextStyle(
    //                               color: Colors.orange.shade700,
    //                               fontWeight: FontWeight.w600,
    //                             ),
    //                           ),
    //                         ],
    //                       ),

    //                       // ------------------- SIGN UP BUTTON -------------------
    //                       Padding(
    //                         padding: const EdgeInsets.only(bottom: 5),
    //                         child: Container(
    //                           width: double.infinity,
    //                           height: 55,
    //                           decoration: BoxDecoration(
    //                             color: const Color(0xFF193C1E),
    //                             borderRadius: BorderRadius.circular(12),
    //                           ),
    //                           child: const Center(
    //                             child: Text(
    //                               "Sign Up",
    //                               style: TextStyle(
    //                                 color: Colors.white,
    //                                 fontSize: 18,
    //                                 fontWeight: FontWeight.bold,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
  }
}
