import 'package:finall/feature/Notifications/presentation_layer/screen/Notifications.dart';
import 'package:finall/feature/setting/presentation_layer/widget/ProfileHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class AuthScaffold extends StatelessWidget {
  final String title;
  final bool? notboldtitle;
  final String? title2;
  final Widget child;
  final String backgroundImage;
  final bool showBackButton;
  final double? paddinglefttitel;
  final double? paddingtopbackbutton;
  final bool? shownotificationbutton;
  final bool? showProfileInTopContainer;
  final bool? NeverScroll;


  const AuthScaffold({
    super.key,
    required this.title,
    this.notboldtitle,
    this.title2,
    required this.showBackButton,
    required this.child,
    this.backgroundImage = 'assets/img/backgroundouth.png',
    this.paddinglefttitel,
    this.paddingtopbackbutton,
    this.shownotificationbutton,
    this.showProfileInTopContainer,
    this.NeverScroll,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            // الصورة
            Container(
              width: MediaQuery.of(context).size.width,
              height: 254,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // العنوان
            Positioned(
              top: 100,
              left: paddinglefttitel ?? 20,
              child: Text(
                title,
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: notboldtitle == true
                      ? FontWeight.w500
                      : FontWeight.bold,
                ),
              ),
            ),

            title2 == null
                ? SizedBox()
                :
                  // العنوان
                  Positioned(
                    top: 150,
                    left: 20,
                    child: Text(
                      title2!,
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

            // زر الرجوع
            if (showBackButton)
              Positioned(
                left: 20,
                top: paddingtopbackbutton ?? 60,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset("assets/svg/Frame 1261154538.svg"),
                ),
              ),

            //الزر تبع النوتيفيكيشن
            if (shownotificationbutton ?? false)
              Positioned(
                right: MediaQuery.sizeOf(context).width * 0.05,
                top: 110,
                child: InkWell(
                  onTap: () {
                    Get.to(() => Notifications());
                  },
                  child: SvgPicture.asset(
                    "assets/svg/hugeicons_notification-02.svg",
                  ),
                ),
              ),

            // الكونتينر الأبيض
            Positioned(
              top: 200,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(top: 43, left: 18, right: 18),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: SingleChildScrollView(
                  physics: (NeverScroll ?? false)
                      ? null
                      : const NeverScrollableScrollPhysics(),
                  child: child,
                ),
              ),
            ),

            // الكومبونينت الشفاف
            if (showProfileInTopContainer == true)
              Positioned(
                top: 150,
                left: 0,
                right: 0,
                child: ProfileHeader(
                  imagePath: 'assets/img/pofile.png',
                  name: 'Ahmad Alhomse',
                  location: 'Maza, Maza gherbea',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
