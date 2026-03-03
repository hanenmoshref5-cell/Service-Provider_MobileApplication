class Government {
  final int id;
  final String name;
  final String svgImage;
  final List<SocialLink> socialLinks;

  Government({
    required this.id,
    required this.name,
    required this.svgImage,
    required this.socialLinks,
  });

  factory Government.fromJson(Map<String, dynamic> json) {
    return Government(
      id: json['id'],
      name: json['name'],
      svgImage: json['svg_image'],
      socialLinks: (json['socialLinks'] as List)
          .map((e) => SocialLink.fromJson(e))
          .toList(),
    );
  }

    static List<Government> fromJsonList(List<dynamic> list) {
    return list.map((e) => Government.fromJson(e)).toList();
  }
}

class SocialLink {
  final int id;
  final String type;
  final String label;
  final String value;

  SocialLink({
    required this.id,
    required this.type,
    required this.label,
    required this.value,
  });

  factory SocialLink.fromJson(Map<String, dynamic> json) {
    return SocialLink(
      id: json['id'],
      type: json['type_case_name'],
      label: json['type_label'],
      value: json['value'],
    );
  }
}
