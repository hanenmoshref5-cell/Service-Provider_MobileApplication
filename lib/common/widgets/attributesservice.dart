import 'package:flutter/material.dart';

class Attributesservice extends StatelessWidget {
  Attributesservice({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 94,
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xffBFCBE3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 12, color: Color(0xffFBFCFE)),
        ),
      ),
    );
  }
}
