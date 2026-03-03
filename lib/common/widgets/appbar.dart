// import 'package:finall/feature/Notifications/presentation_layer/screen/Notifications.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class Appbar extends StatelessWidget {
  Appbar({super.key, required this.texttitle, required this.onPressed});
  final String texttitle;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/img/photo5247167296940648547 1.png",
                height: 180,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 80,
                right: 0,
                left: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: onPressed,
                      icon: Image.asset("assets/img/home_img/Arrow-Left.png"),
                    ),
                    SizedBox(width: 20),
                    Text(
                      texttitle,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffFBFCFE),
                      ),
                    ),
                    Spacer(),

                    // IconButton(
                    //   onPressed: () {
                    //     Get.to(() => Notifications());
                    //   },
                    //   icon: Image.asset("assets/img/Group.png"),
                    // ),
                  ],
                ),
              ),
              Positioned(
                top: 150,
                right: 0,
                left: 0,
                child: Container(
                  alignment: Alignment.centerRight,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
