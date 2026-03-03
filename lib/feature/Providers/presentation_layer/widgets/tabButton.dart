import 'package:finall/feature/Providers/busness_logic_layer/providerscontroller.dart';
import 'package:flutter/material.dart';

class Tabbutton extends StatelessWidget {
  Tabbutton({super.key, required this.title, required this.index});
  final String title;
  final int index;
  final Providerscontroller controller = Providerscontroller();

  @override
  Widget build(BuildContext context) {
    final isSelected = controller.selectedTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Color(0xffFF8C33) : Color(0xffF1F1F1),
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 4),
                height: 3,
                width: 30,
                color: Color(0xffFF8C33),
              ),
          ],
        ),
      ),
    );
  }
}
