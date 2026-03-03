class CategoryClass {
  final int id;
  final String name;
  final String description;
  final String svgImage;

  CategoryClass({
    required this.id,
    required this.name,
    required this.description,
    required this.svgImage,
  });

  factory CategoryClass.fromJson(Map<String, dynamic> json) {
    return CategoryClass(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      svgImage: json['svg_image'],
    );
  }
  static List<CategoryClass> fromJsonList(List list) {
    return list.map((e) => CategoryClass.fromJson(e)).toList();
  }
}

class SubCategoryClass {
  final int id;
  final String name;
  final String description;
  final String svgImage;

  SubCategoryClass({
    required this.id,
    required this.name,
    required this.description,
    required this.svgImage,
  });

  factory SubCategoryClass.fromJson(Map<String, dynamic> json) {
    return SubCategoryClass(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      svgImage: json['svg_image'],
    );
  }

  static List<SubCategoryClass> fromJsonList(List list) {
    return list.map((json) => SubCategoryClass.fromJson(json)).toList();
  }
}
