import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerBox extends StatefulWidget {
  const ImagePickerBox({super.key});

  @override
  State<ImagePickerBox> createState() => _ImagePickerBoxState();
}

class _ImagePickerBoxState extends State<ImagePickerBox> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: 124,
        height: 94,
        decoration: BoxDecoration(
          color: const Color(0xFFFFD2B0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: _selectedImage == null
            ? Center(
              child: SvgPicture.asset("assets/svg/comera.svg",width: 50,height: 41,),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  _selectedImage!,
                  width: 124,
                  height: 94,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}

