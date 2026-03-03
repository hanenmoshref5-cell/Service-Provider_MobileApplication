import 'package:finall/common/widget/auth_scafold.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: "Notifications",
      paddinglefttitel: 100,
      notboldtitle: true,
      showBackButton: true,
      child: Column(
        spacing: 30,
        children: [
          SizedBox(height: 55),
          Image.asset("assets/img/Frame 1597882151.png"),
        ],
      ),
    );
  }
}
