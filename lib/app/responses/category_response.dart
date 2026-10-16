class CategoryResponse {
  bool? status;
  List<Category>? category;

  CategoryResponse({this.status, this.category});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      category = <Category>[];
      json['data'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (category != null) {
      data['data'] = category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? id;
  String? name;
  String? slug;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? subCategories;
  String? description;

  Category(
      {this.id,
      this.name,
      this.slug,
      this.createdAt,
      this.updatedAt,
      this.subCategories,
      this.description});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['subCategories'] != null) {
      subCategories = <dynamic>[];
      json['subCategories'].forEach((v) {
        subCategories!.add(v);
      });
    }
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (subCategories != null) {
      data['subCategories'] = subCategories!.map((v) => v.toJson()).toList();
    }
    data['description'] = description;
    return data;
  }
}
