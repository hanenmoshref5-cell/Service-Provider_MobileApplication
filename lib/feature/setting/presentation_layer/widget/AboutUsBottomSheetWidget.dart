import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsBottomSheetWidget extends StatelessWidget {
  final VoidCallback onClose;

  const AboutUsBottomSheetWidget({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // العنوان + زر الإغلاق
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 40),
              Text(
                "About Us",
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: onClose,
                iconSize: 30,
                color: const Color.fromARGB(255, 179, 176, 176),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // النص التعريفي
          Text(
            "Welcome to our platform — your trusted space for connecting skilled service providers with customers who need them. We believe in making everyday life easier by helping people find reliable professionals for tasks like home maintenance, personal care, logistics, tutoring, and more...",
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: 20),

          // أزرار التواصل
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _contactButton('Facebook', Icons.facebook),
              _contactButton('Instagram', Icons.camera_alt),
              _contactButton('WhatsApp', Icons.wechat_rounded),
              _contactButton('Phone', Icons.call),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contactButton(String title, IconData icon) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Color(0xFFFF8C33)),
      label: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFFF8C33),
          fontWeight: FontWeight.w500,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFFE86500)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
