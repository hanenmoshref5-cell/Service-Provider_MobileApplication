import 'package:finall/feature/setting/presentation_layer/widget/ProfileHeader.dart';
import 'package:finall/feature/Notifications/presentation_layer/screen/Notifications.dart';
import 'package:flutter/material.dart';
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
  final bool? neverScroll;

  const AuthScaffold({
    super.key,
    required this.title,
    this.notboldtitle,
    this.title2,
    required this.showBackButton,
    required this.child,
    this.backgroundImage = "assets/img/photo5247167296940648547 1.png",

    this.paddinglefttitel,
    this.paddingtopbackbutton,
    this.shownotificationbutton,
    this.showProfileInTopContainer,
    this.neverScroll,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
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
                : Positioned(
                    top: 140,
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

            if (showBackButton)
              Positioned(
                left: 20,
                top: paddingtopbackbutton ?? 50,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset("assets/img/Frame 1261154538.png"),
                ),
              ),

            if (shownotificationbutton ?? false)
              Positioned(
                right: MediaQuery.sizeOf(context).width * 0.05,
                top: 110,
                child: IconButton(
                  onPressed: () {
                    Get.to(() => Notifications());
                  },
                  icon: Image.asset("assets/img/Group.png"),
                ),
              ),

            Positioned(
              top: 170,
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
                  physics: (neverScroll ?? false)
                      ? null
                      : const NeverScrollableScrollPhysics(),
                  child: child,
                ),
              ),
            ),

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
