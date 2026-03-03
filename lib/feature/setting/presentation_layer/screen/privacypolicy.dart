import 'package:finall/common/widget/auth_scafold.dart';
import 'package:flutter/material.dart';

class Privacypolicy extends StatelessWidget {
  const Privacypolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: "Privacy Policy",
      showBackButton: true,
      notboldtitle: true,
      shownotificationbutton: true,
      NeverScroll: true,
      paddinglefttitel: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Privacy Policy",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color(0xff5A5A5A),
            ),
          ),
          SizedBox(height: 20),

          _policyItem("1. User Agreement"),
          _policyText(),

          _policyItem("2. Payment Terms"),
          _policyText(),

          _policyItem("3. Service Provider Obligations"),
          _policyText(),

          _policyItem("4. User Responsibilities"),
          _policyText(),

          _policyItem("5. Payment Terms"),
          _policyText(),

          _policyItem("6. Service Provider Obligations"),
          _policyText(),
        ],
      ),
    );
  }
}

Widget _policyItem(String title) {
  return Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 6),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xff5A5A5A),
      ),
    ),
  );
}

Widget _policyText() {
  return Text(
    "This agreement defines the terms under which users can access and use the app. It includes rules about account creation, appropriate use of the platform, and the rights and responsibilities of both the user and the service provider.",
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xff5A5A5A),
    ),
    textAlign: TextAlign.justify,
  );
}
