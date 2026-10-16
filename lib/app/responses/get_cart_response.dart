import 'package:old_delhi_food/app/responses/product_detail_response.dart';
import 'package:get/get.dart'; // Import GetX package

class GetCartResponse {
  bool? status;
  Data? data;

  GetCartResponse({this.status, this.data});

  GetCartResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? createdAt;
  String? updatedAt;
  List<CardItems>? cardItems;

  Data({this.id, this.createdAt, this.updatedAt, this.cardItems});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['cardItems'] != null) {
      cardItems = <CardItems>[];
      json['cardItems'].forEach((v) {
        cardItems!.add(CardItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (cardItems != null) {
      data['cardItems'] = cardItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardItems {
  String? id;
  ProductItem? productItem;
  RxInt count = 0.obs; // Use RxInt instead of int?
  String? createdAt;
  String? updatedAt;

  CardItems(
      {this.id,
      this.productItem,
      required this.count,
      this.createdAt,
      this.updatedAt});

  CardItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productItem = json['productItem'] != null
        ? ProductItem.fromJson(json['productItem'])
        : null;
    count.value = json['count'] ?? 0; // Assign value to RxInt
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (productItem != null) {
      data['productItem'] = productItem!.toJson();
    }
    data['count'] = count.value; // Retrieve value from RxInt
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class ProductItem {
  String? id;
  Product? product;
  String? sku;
  String? stock;
  int? price;
  int? weight;
  List<ProductConfig>? productConfig;
  List<Images>? images;
  String? createdAt;
  String? updatedAt;

  ProductItem(
      {this.id,
      this.product,
      this.sku,
      this.stock,
      this.price,
      this.weight,
      this.productConfig,
      this.images,
      this.createdAt,
      this.updatedAt});

  ProductItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    sku = json['sku'];
    stock = json['stock'];
    price = json['price'];
    weight = json['weight'];
    if (json['productConfig'] != null) {
      productConfig = <ProductConfig>[];
      json['productConfig'].forEach((v) {
        productConfig!.add(ProductConfig.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['sku'] = sku;
    data['stock'] = stock;
    data['price'] = price;
    if (productConfig != null) {
      data['productConfig'] = productConfig!.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Product {
  String? id;
  String? name;
  String? slug;
  String? status;
  String? description;
  Shop? shop;
  int? price;
  List<ProductTag>? productTag;
  TimeSlot? timeSlot;
  String? minOrderQuantity;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
      this.name,
      this.slug,
      this.status,
      this.description,
      this.shop,
      this.price,
      this.productTag,
      this.timeSlot,
      this.minOrderQuantity,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    status = json['status'];
    description = json['description'];
    shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
    price = json['price'];
    if (json['productTag'] != null) {
      productTag = <ProductTag>[];
      json['productTag'].forEach((v) {
        productTag!.add(ProductTag.fromJson(v));
      });
    }
    timeSlot = TimeSlot.fromJson(json['timeSlot']);
    minOrderQuantity = json['minOrderQuantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['status'] = status;
    data['description'] = description;
    if (shop != null) {
      data['shop'] = shop!.toJson();
    }
    data['price'] = price;
    if (productTag != null) {
      data['productTag'] = productTag!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Shop {
  String? id;
  String? name;
  String? slug;
  String? description;
  List<Images>? images;
  String? createdAt;
  String? updatedAt;

  Shop(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.images,
      this.createdAt,
      this.updatedAt});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['description'] = description;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Images {
  String? id;
  String? url;
  String? createdAt;
  String? updatedAt;

  Images({this.id, this.url, this.createdAt, this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class ProductTag {
  String? id;
  String? name;
  String? slug;
  String? description;
  String? createdAt;
  String? updatedAt;

  ProductTag(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.createdAt,
      this.updatedAt});

  ProductTag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class TimeSlot {
  String id;
  String slot;
  String startTime;
  String endTime;
  DateTime createdAt;
  DateTime updatedAt;

  TimeSlot({
    required this.id,
    required this.slot,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      id: json['id'],
      slot: json['slot'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
