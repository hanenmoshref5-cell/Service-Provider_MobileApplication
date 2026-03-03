class SliderItem {
  final String image;
  final int providerId;

  SliderItem({required this.image, required this.providerId});

  factory SliderItem.fromJson(Map<String, dynamic> json) {
    return SliderItem(
      image: json['image'] ?? '',
      providerId: json['service_provider']?['id'] ?? '',
    );
  }

  static List<SliderItem> fromJsonList(List list) {
    return list.map((e) => SliderItem.fromJson(e)).toList();
  }
}
