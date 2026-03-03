import 'package:flutter/material.dart';
import 'filter_type.dart';

class FilterOption {
  final String title;
  final IconData icon;
  final FilterType type;

  const FilterOption({
    required this.title,
    required this.icon,
    required this.type,
  });
}
