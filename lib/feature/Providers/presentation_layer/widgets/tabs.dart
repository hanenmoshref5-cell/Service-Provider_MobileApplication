import 'package:finall/feature/Providers/presentation_layer/widgets/tabButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tabs extends StatelessWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Tabbutton(title: "Details", index: 0),
          Tabbutton(title: "Gallery", index: 1),
          Tabbutton(title: "Offers", index: 2),
        ],
      ),
    );
  }
}
