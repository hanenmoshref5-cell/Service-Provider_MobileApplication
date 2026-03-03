import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Contactbutton extends StatelessWidget {
  const Contactbutton({
    super.key,
    required this.title,
    required this.icon,
    this.onPressed,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: FaIcon(icon, color: Color(0xFFFF6F00), size: 20),
      label: Text(title, style: const TextStyle(color: Color(0xFFFF6F00))),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFFFF6F00)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      ),
    );
  }
}
