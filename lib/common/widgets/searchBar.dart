import 'package:flutter/material.dart';

class Searchbarr extends StatelessWidget {
  Searchbarr({super.key, this.onchange});
  final void Function(String)? onchange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        margin: EdgeInsets.all(7),
        padding: EdgeInsets.only(top: 14, bottom: 14, left: 20, right: 20),
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xffBFCBE3)),
        ),
        child: Row(
          textDirection: TextDirection.ltr,
          children: [
            Image.asset('assets/img/search-normal.png', width: 20, height: 20),

            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: '..Search',
                  border: InputBorder.none,
                  isCollapsed: true,
                ),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                onChanged: onchange,
              ),
            ),
            Spacer(),
            Image.asset("assets/img/settings-sliders (1) 1.png"),
          ],
        ),
      ),
    );
  }
}
