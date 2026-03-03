// import 'package:finall/feature/Notifications/presentation_layer/screen/Notifications.dart';
import 'package:finall/feature/Home/presentation_layer/widget/AppProfileForHome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homeappbar extends StatelessWidget {
  const Homeappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset("assets/img/photo5247167296940648547 1.png"),
              Positioned(
                top: 80,
                right: 0,
                left: 0,
                child: AppProfileForHome(),
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
              Positioned(
                top: 160,
                left: 20,
                right: 0,
                child: SizedBox(
                  width: 304,
                  height: 68,

                  child: Column(
                    children: [
                      Row(
                        textDirection: TextDirection.ltr,

                        children: [
                          Text(
                            "Lets Find The".tr,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff010A1C),
                            ),
                          ),
                          Text(
                            "perfect ".tr,
                            style: TextStyle(
                              color: Color(0xffFF8C33),
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        textDirection: TextDirection.ltr,
                        children: [
                          Text(
                            " Service ".tr,
                            style: TextStyle(
                              color: Color(0xffFF8C33),
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Export".tr,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff010A1C),
                            ),
                          ),
                        ],
                      ),
                    ],
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
