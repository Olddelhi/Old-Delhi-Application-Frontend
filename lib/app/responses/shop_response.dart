class ShopResponse {
  bool? status;
  List<Shop>? shop;
  int? total;
  int? page;
  int? limit;
  int? totalPage;

  ShopResponse(
      {this.status,
      this.shop,
      this.total,
      this.page,
      this.limit,
      this.totalPage});

  ShopResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      shop = <Shop>[];
      json['data'].forEach((v) {
        shop!.add(Shop.fromJson(v));
      });
    }
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (shop != null) {
      data['data'] = shop!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['page'] = page;
    data['limit'] = limit;
    data['totalPage'] = totalPage;
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
