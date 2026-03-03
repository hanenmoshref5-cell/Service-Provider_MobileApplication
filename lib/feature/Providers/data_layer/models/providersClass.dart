import 'package:finall/feature/categories/data_layer/models/categoryClass.dart';

class Provider {
  final int id;
  final String shopName;
  final String providerName;
  final String description;
  final String? address;
  final String imageUrl;
  final int views;
  SubCategoryClass subCategory;
  final List<String> gallery;

  Provider({
    required this.id,
    required this.shopName,
    required this.providerName,
    required this.description,
    required this.address,
    required this.imageUrl,
    required this.views,
    required this.subCategory,
    required this.gallery,
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    // نضمن إنو media موجودة
    final media = json['media'] ?? {};

    // نضمن إنو image list أو فاضية
    final imageList = (media['image'] is List) ? media['image'] as List : [];

    // نضمن إنو gallery list أو فاضية
    final galleryList = (media['gallery'] is List)
        ? media['gallery'] as List
        : [];

    return Provider(
      id: json['id'],
      shopName: json['shop_name'] ?? '',
      providerName: json['provider_name'] ?? '',
      description: json['description'] ?? '',
      address: json['address'],
      subCategory: SubCategoryClass.fromJson(json['subCategory']),
      imageUrl: imageList.isNotEmpty
          ? imageList[0]['original_url'] ?? ''
          : (json['image'] is List && json['image'].isNotEmpty)
          ? json['image'][0]['original_url'] ?? ''
          : '',
      views: json['views'] ?? 0,
      gallery: galleryList
          .map<String>((e) => e['original_url']?.toString() ?? '')
          .where((e) => e.isNotEmpty)
          .toList(),
    );
  }

  static List<Provider> fromJsonList(List<dynamic> list) {
    return list.map((e) => Provider.fromJson(e)).toList();
  }
}
