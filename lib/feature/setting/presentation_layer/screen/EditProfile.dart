import 'dart:developer';
import 'package:finall/common/widget/auth_scafold.dart';
import 'package:finall/feature/auth/business_logic_layer/auth_controller.dart';
import 'package:finall/feature/auth/presntation_layer/widget/CustomInputField.dart';
import 'package:finall/feature/auth/presntation_layer/widget/mainbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'dart:io';

// ignore: must_be_immutable
class Editprofile extends StatefulWidget {
  Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late AuthController authController;
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  File? selectedImage;
  String? selectedCityId;
  String? selectedStateName;

  // Sample data - replace with API data
  List<Map<String, dynamic>> states = [
    {'id': 1, 'name': 'Riyadh'},
    {'id': 2, 'name': 'Mecca'},
    {'id': 3, 'name': 'Medina'},
  ];

  List<Map<String, dynamic>> cities = [
    {'id': 1, 'name': 'Riyadh', 'stateId': 1},
    {'id': 2, 'name': 'Mecca', 'stateId': 2},
    {'id': 3, 'name': 'Medina', 'stateId': 3},
  ];

  @override
  void initState() {
    super.initState();
    authController = Get.put(AuthController());
    // Load profile data into fields
    final profile = authController.profileData.value;
    if (profile != null) {
      firstnamecontroller.text = profile.firstName;
      lastnamecontroller.text = profile.lastName;
      phonecontroller.text = profile.phone;
      selectedCityId = profile.cityId.toString();
      selectedStateName = profile.city?.state?.name;
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
      log("Image selected: ${image.path}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: "Edit Profile",
      showBackButton: true,
      paddinglefttitel: MediaQuery.sizeOf(context).width * 0.28,
      paddingtopbackbutton: 100,
      shownotificationbutton: true,
      notboldtitle: true,
      child: Form(
        key: _key,
        child: Column(
          spacing: 30,
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: Stack(
                children: [
                  Positioned(
                    child: CircleAvatar(
                      radius: 57,
                      foregroundImage: selectedImage != null
                          ? FileImage(selectedImage!)
                          : AssetImage("assets/img/pofile.png")
                                as ImageProvider,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: pickImage,
                      icon: SvgPicture.asset("assets/svg/iconpen.svg"),
                    ),
                  ),
                ],
              ),
            ),

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
                    value: selectedStateName,
                    decoration: InputDecoration(
                      hint: Text(
                        "State",
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          color: const Color(0xff717171),
                        ),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset("assets/svg/State4.svg"),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: SvgPicture.asset(
                          "assets/svg/chevron-down-s.svg",
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    items: states
                        .map<DropdownMenuItem<String>>(
                          (state) => DropdownMenuItem<String>(
                            value: state['name'],
                            child: Text(state['name']),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select state";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        selectedStateName = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    value: selectedCityId,
                    decoration: InputDecoration(
                      hint: Text(
                        "City",
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          color: const Color(0xff717171),
                        ),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset("assets/svg/building 1.svg"),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: SvgPicture.asset(
                          "assets/svg/chevron-down-s.svg",
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    items: cities
                        .map<DropdownMenuItem<String>>(
                          (city) => DropdownMenuItem<String>(
                            value: city['id'].toString(),
                            child: Text(city['name']),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select city";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        selectedCityId = value;
                      });
                    },
                  ),
                ),
              ],
            ),

            GetX<AuthController>(
              builder: (controller) => MainButton(
                text: controller.isLoading.value ? "Saving..." : "Save",
                onPressed: controller.isLoading.value
                    ? () {}
                    : () {
                        if (_key.currentState!.validate()) {
                          controller.updateProfile(
                            firstName: firstnamecontroller.text,
                            lastName: lastnamecontroller.text,
                            phone: phonecontroller.text,
                            cityId: selectedCityId ?? "1",
                            imagePath: selectedImage?.path,
                          );
                        }
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
