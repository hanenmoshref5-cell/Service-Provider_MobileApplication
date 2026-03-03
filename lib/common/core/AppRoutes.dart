import 'package:finall/feature/auth/presntation_layer/screen/Forgetpassword.dart';
import 'package:finall/feature/auth/presntation_layer/screen/LoginafterResetPass.dart';
import 'package:finall/feature/auth/presntation_layer/screen/SignUp.dart';
// import 'package:finall/feature/auth/presntation_layer/screen/VerifyCode.dart';
import 'package:finall/feature/auth/presntation_layer/screen/login.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String loginc = "/";
  static const String signupc = "/signupc";
  static const String verifycodec = "/verifycodec";
  static const String resetpassc = "/resetpassc";
  static const String forgetpassc = "/forgetpassc";
  static const String loginafterresetpassc = "/loginafterresetpassc";

  static Map<String, WidgetBuilder> routes = {
    loginc: (context) => Login(),
    signupc: (context) => Signup(),
    // verifycodec: (context) =>  Verifycode(phone: ""),
    forgetpassc: (context) => Forgetpassword(),
    loginafterresetpassc: (context) => Loginafterresetpass(),
  };
}
