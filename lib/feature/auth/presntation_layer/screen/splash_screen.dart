import 'package:finall/feature/auth/data_layer/source/auth_service.dart';
import 'package:finall/feature/auth/presntation_layer/screen/login.dart';
import 'package:finall/common/core/homeMaster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final OuthService _authService = OuthService();

  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    
    await Future.delayed(const Duration(seconds: 2));


      String? token =_authService.box.read('my_auth');
      if (token != null) {
        Get.off(HomeMaster());
      } else {
        Get.off(Login());
      }


  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/img/Simplification (1).png",
          width: 270,
          height: 241,
        ),
      ),
    );
  }
}
