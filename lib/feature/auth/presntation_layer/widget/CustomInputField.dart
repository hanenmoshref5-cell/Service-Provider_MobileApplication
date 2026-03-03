import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputField extends StatelessWidget {
  final String hint;
  final Widget? prefix;
  final Widget? suffix;
  final bool isPassword;
  final bool isPhone;
  final bool isName;
  final TextEditingController? controller;
  // للمقارنة (مثل تأكيد الباسورد)
  final TextEditingController? compareWith;

  const CustomInputField({
    super.key,
    required this.hint,
    this.prefix,
    this.suffix,
    this.isPassword = false,
    this.isPhone = false,
    this.isName = false,
    this.controller,
    this.compareWith,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      keyboardType: isPhone
          ? TextInputType.phone
              : TextInputType.text,

      obscureText: isPassword,
      obscuringCharacter: '*',

      validator: (value) {
        if (value == null || value.isEmpty) {
          return "* is required";
        }

        if (isName && value.length < 3) {
          return "Name too short";
        }

        if (isPhone && value.length < 9) {
          return "Invalid phone number";
        }


        if (isPassword && value.length < 6) {
          return "Password must be at least 6 characters";
        }

        // مقارنة الباسورد
        if (compareWith != null) {
          if (value != compareWith!.text) {
            return "Passwords do not match";
          }
        }

        return null;
      },

      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.lato(
          fontSize: 12,
          color: const Color(0xff717171),
        ),

        prefixIcon: prefix != null
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: prefix,
              )
            : null,

        suffixIcon: suffix != null
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: suffix,
              )
            : null,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
