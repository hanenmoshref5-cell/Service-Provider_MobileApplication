import 'package:finall/feature/Entities/busness_logic_layer/entities_controller.dart';
import 'package:finall/feature/Entities/data_layer/models/entitiesClass.dart';
import 'package:finall/common/widgets/contactButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class ministryCardGridvie extends StatelessWidget {
  ministryCardGridvie({super.key});
  final EntitiesController controller = Get.put(EntitiesController());

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 2.5,
        ),
        itemCount: controller.government.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xff3E4E2C),
              border: Border.all(color: const Color(0xff3E4E2C)),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                SvgPicture.string(
                  controller.government[index].svgImage,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    controller.government[index].name,
                    style: const TextStyle(
                      color: Color(0xffE6E8EE),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    showMinistryBottomSheet(
                      context,
                      controller.government[index],
                    );
                  },
                  child: Image.asset(
                    "assets/img/n/circle-phone 3 (1).png",
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void showMinistryBottomSheet(BuildContext context, Government ministry) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 60),
                    SvgPicture.string(
                      ministry.svgImage,
                      width: 28,
                      height: 28,
                      color: Color(0xff3E4E2C),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      ministry.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: ministry.socialLinks.map((link) {
                return Contactbutton(
                  title: link.label,
                  icon: _getIcon(link.type),

                  onPressed: () {
                    openLink(link.value, link.type);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      );
    },
  );
}

IconData _getIcon(String type) {
  switch (type.toUpperCase()) {
    case 'PHONE':
      return Icons.call;
    case 'FACEBOOK':
      return Icons.facebook;
    case 'INSTAGRAM':
      return Icons.camera_alt;
    default:
      return Icons.link;
  }
}

Future<void> openLink(String value, String type) async {
  Uri uri;

  switch (type.toUpperCase()) {
    case 'PHONE':
      final phone = value
          .replaceAll(' ', '')
          .replaceAll('-', '')
          .replaceAll('+', '');
      uri = Uri.parse('tel:$phone');
      break;

    case 'WHATSAPP':
      final phone = value
          .replaceAll(' ', '')
          .replaceAll('-', '')
          .replaceAll('+', '');
      uri = Uri.parse('https://wa.me/$phone');
      break;

    default:
      uri = Uri.parse(value);
  }

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    debugPrint(' Could not launch $uri');
  }
}
