import 'package:finall/common/widgets/attributesservice.dart';
import 'package:finall/common/widgets/contactButton.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 5),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 20,
          children: [
            Text(
              "Description",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Text(
              "Friendly and detail-oriented service worker with experience in card and gift retail. Assists customers in selecting greeting cards for all occasionsFriendly and detail-oriented service worker with experience in card and gift retail. Assists customers in selecting greeting cards for all occasions,retail. Assists customers in selecting greeting cards for all occasions ... View More ",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff717171),
              ),
            ),
            Row(
              spacing: 9,
              children: [
                Expanded(child: Attributesservice(title: "#Exterior")),
                Expanded(child: Attributesservice(title: "#Services")),
                Expanded(child: Attributesservice(title: "#Tire")),
                Expanded(child: Attributesservice(title: "#Services")),
              ],
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 15,
                children: [
                  Text(
                    "Contact Details",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    spacing: 7,
                    children: [
                      Expanded(
                        child: Contactbutton(
                          title: "phone Number",
                          icon: Icons.call,
                        ),
                      ),
                      Expanded(
                        child: Contactbutton(
                          title: "Whats App",
                          icon: Icons.add_call,
                        ),
                      ),

                      Expanded(
                        child: Contactbutton(
                          title: "Facebook",
                          icon: Icons.facebook,
                        ),
                      ),
                    ],
                  ),
                  Contactbutton(title: "Instagram", icon: Icons.camera_alt),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
