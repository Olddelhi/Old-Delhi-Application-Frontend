class BannerModel {
  final String id;
  final ImageModel image;
  final String name;
  final CategoryModel category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int position;

  BannerModel({
    required this.id,
    required this.image,
    required this.name,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
   required this.position,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      image: ImageModel.fromJson(json['image']),
      name: json['name'],
      category: CategoryModel.fromJson(json['category']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      position: json['position']
    );
  }
}

class ImageModel {
  final String id;
  final String url;
  final DateTime createdAt;
  final DateTime updatedAt;

  ImageModel({
    required this.id,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      url: json['url'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class CategoryModel {
  final String id;
  final String name;
  final String slug;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String description;
  final ImageModel? image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      description: json['description'],
      image: json['image'] != null ? ImageModel.fromJson(json['image']) : null,
    );
  }
}
