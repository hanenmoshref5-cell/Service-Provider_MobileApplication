class OfferModel {
  final int id;
  final String title;
  final String image;
  final String shopName;
  final String providerName;
  final String providerImage;
  final String status;

  OfferModel({
    required this.id,
    required this.title,
    required this.image,
    required this.shopName,
    required this.providerName,
    required this.providerImage,

    required this.status,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      title: json['title'] ?? '',
      image:
          json['media']?['image'] != null && json['media']['image'].isNotEmpty
          ? json['media']['image'][0]['original_url']
          : '',
      shopName: json['serviceProvider']?['shop_name'] ?? '',
      providerName: json['serviceProvider']?['provider_name'] ?? '',
      providerImage: "",

      status: json['status_label'] ?? '',
    );
  }

  static List<OfferModel> fromJsonList(Map<String, dynamic> json) {
    List<OfferModel> list = [];

    if (json['data'] != null) {
      for (var element in json['data']) {
        list.add(OfferModel.fromJson(element));
      }
    }

    return list;
  }
}
