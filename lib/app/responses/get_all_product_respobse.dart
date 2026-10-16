// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  bool status;
  List<Datum> data;
  int total;
  int page;
  int limit;
  int totalPage;

  Product({
    required this.status,
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPage,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    total: json["total"],
    page: json["page"],
    limit: json["limit"],
    totalPage: json["totalPage"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total": total,
    "page": page,
    "limit": limit,
    "totalPage": totalPage,
  };
}

class Datum {
  String id;
  String name;
  String slug;
  Status status;
  String description;
  Category shop;
  int price;
  List<dynamic> productTag;
  List<ProductItem> productItems;
  bool isActive;
  Category category;
  DateTime createdAt;
  DateTime updatedAt;
  Type? type;

  Datum({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
    required this.description,
    required this.shop,
    required this.price,
    required this.productTag,
    required this.productItems,
    required this.isActive,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    this.type,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    status: statusValues.map[json["status"]]!,
    description: json["description"],
    shop: Category.fromJson(json["shop"]),
    price: json["price"],
    productTag: List<dynamic>.from(json["productTag"].map((x) => x)),
    productItems: List<ProductItem>.from(json["productItems"].map((x) => ProductItem.fromJson(x))),
    isActive: json["isActive"],
    category: Category.fromJson(json["category"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    type: Type.fromJson(json['type']),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "status": statusValues.reverse[status],
    "description": description,
    "shop": shop.toJson(),
    "price": price,
    "productTag": List<dynamic>.from(productTag.map((x) => x)),
    "productItems": List<dynamic>.from(productItems.map((x) => x.toJson())),
    "isActive": isActive,
    "category": category.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "type": type?.toJson(),
  };
}

class Category {
  String id;
  String name;
  String slug;
  DateTime createdAt;
  DateTime updatedAt;
  String description;
  dynamic image;
  bool? isActive;
  List<Image>? images;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    this.image,
    this.isActive,
    this.images,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    description: json["description"],
    image: json["image"],
    isActive: json["isActive"],
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "description": description,
    "image": image,
    "isActive": isActive,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
  };
}

class Image {
  String id;
  String url;
  DateTime createdAt;
  DateTime updatedAt;

  Image({
    required this.id,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    url: json["url"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class ProductItem {
  String id;
  ProductClass product;
  String sku;
  String stock;
  int price;
  List<ProductConfig> productConfig;
  bool isActive;
  List<Image> images;
  DateTime createdAt;
  DateTime updatedAt;

  ProductItem({
    required this.id,
    required this.product,
    required this.sku,
    required this.stock,
    required this.price,
    required this.productConfig,
    required this.isActive,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
    id: json["id"],
    product: ProductClass.fromJson(json["product"]),
    sku: json["sku"],
    stock: json["stock"],
    price: json["price"],
    productConfig: List<ProductConfig>.from(json["productConfig"].map((x) => ProductConfig.fromJson(x))),
    isActive: json["isActive"],
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product.toJson(),
    "sku": sku,
    "stock": stock,
    "price": price,
    "productConfig": List<dynamic>.from(productConfig.map((x) => x.toJson())),
    "isActive": isActive,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Type {
  String id;
  String name;
  String slug;
  String description;
  Image image;
  DateTime createdAt;
  DateTime updatedAt;

  Type({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"],
    image: Image.fromJson(json["image"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "description": description,
    "image": image.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}


class ProductClass {
  String id;
  String name;
  String slug;
  Status status;
  String description;
  int price;
  bool isActive;
  DateTime createdAt;
  DateTime updatedAt;

  ProductClass({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
    required this.description,
    required this.price,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductClass.fromJson(Map<String, dynamic> json) => ProductClass(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    status: statusValues.map[json["status"]]!,
    description: json["description"],
    price: json["price"],
    isActive: json["isActive"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "status": statusValues.reverse[status],
    "description": description,
    "price": price,
    "isActive": isActive,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

enum Status {
  PUBLISHED
}

final statusValues = EnumValues({
  "published": Status.PUBLISHED
});

class ProductConfig {
  String id;

  ProductConfig({
    required this.id,
  });

  factory ProductConfig.fromJson(Map<String, dynamic> json) => ProductConfig(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
