import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProviderGallerySlider extends StatefulWidget {
  final List<String> images;

  const ProviderGallerySlider({super.key, required this.images});

  @override
  State<ProviderGallerySlider> createState() => _ProviderGallerySliderState();
}

class _ProviderGallerySliderState extends State<ProviderGallerySlider> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.images.map((img) {
            return _sliderItem(img);
          }).toList(),
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
        ),

        const SizedBox(height: 10),

        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: widget.images.length,
          effect: WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            spacing: 6,
            activeDotColor: const Color(0xFFFF6F00),
            dotColor: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  Widget _sliderItem(String imageUrl) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          imageUrl,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}