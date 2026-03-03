import 'package:flutter/material.dart';

class LanguageBottomSheetWidget extends StatelessWidget {
  final VoidCallback onClose;
  final Function(String) onSelect;

  const LanguageBottomSheetWidget({
    super.key,
    required this.onClose,
    required this.onSelect,
  });

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
                "Language",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              IconButton(icon: const Icon(Icons.close), onPressed: onClose,color: const Color.fromARGB(255, 118, 116, 116),iconSize: 24,),
            ],
          ),

          const SizedBox(height: 20),

          // خيار اللغة: English
          _languageOption("English"),

          const SizedBox(height: 12),

          // خيار اللغة: Arabic
          _languageOption("Arabic"),
        ],
      ),
    );
  }

  Widget _languageOption(String label) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12),
      shape: RoundedRectangleBorder(
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xff000000),
        ),
      ),
      onTap: () => onSelect(label),
    );
  }




}
