// import 'package:old_delhi_food/app/responses/get_cart_response.dart';
//
// class SpecificCategoryResponse {
//   bool? status;
//   List<CategoryDetail>? categoryDetail;
//   int? total;
//   int? page;
//   int? limit;
//   int? totalPage;
//
//   SpecificCategoryResponse(
//       {this.status,
//         this.categoryDetail,
//         this.total,
//         this.page,
//         this.limit,
//         this.totalPage});
//
//   SpecificCategoryResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       categoryDetail = <CategoryDetail>[];
//       json['data'].forEach((v) {
//         categoryDetail!.add(new CategoryDetail.fromJson(v));
//       });
//     }
//     total = json['total'];
//     page = json['page'];
//     limit = json['limit'];
//     totalPage = json['totalPage'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.categoryDetail != null) {
//       data['data'] = this.categoryDetail!.map((v) => v.toJson()).toList();
//     }
//     data['total'] = this.total;
//     data['page'] = this.page;
//     data['limit'] = this.limit;
//     data['totalPage'] = this.totalPage;
//     return data;
//   }
// }
//
// class CategoryDetail {
//   String? id;
//   String? name;
//   String? slug;
//   String? status;
//   String? description;
//   Shop? shop;
//   int? price;
//   List<ProductTag>? productTag;
//   List<ProductItems>? productItems;
//   bool? isActive;
//   Category? category;
//   String? createdAt;
//   String? updatedAt;
//
//   CategoryDetail(
//       {this.id,
//         this.name,
//         this.slug,
//         this.status,
//         this.description,
//         this.shop,
//         this.price,
//         this.productTag,
//         this.productItems,
//         this.isActive,
//         this.category,
//         this.createdAt,
//         this.updatedAt});
//
//   CategoryDetail.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     slug = json['slug'];
//     status = json['status'];
//     description = json['description'];
//     shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
//     price = json['price'];
//     if (json['productTag'] != null) {
//       productTag = <ProductTag>[];
//       json['productTag'].forEach((v) {
//         productTag!.add(new ProductTag.fromJson(v));
//       });
//     }
//     if (json['productItems'] != null) {
//       productItems = <ProductItems>[];
//       json['productItems'].forEach((v) {
//         productItems!.add(new ProductItems.fromJson(v));
//       });
//     }
//     isActive = json['isActive'];
//     category = json['category'] != null
//         ? new Category.fromJson(json['category'])
//         : null;
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['slug'] = this.slug;
//     data['status'] = this.status;
//     data['description'] = this.description;
//     if (this.shop != null) {
//       data['shop'] = this.shop!.toJson();
//     }
//     data['price'] = this.price;
//     if (this.productTag != null) {
//       data['productTag'] = this.productTag!.map((v) => v.toJson()).toList();
//     }
//     if (this.productItems != null) {
//       data['productItems'] = this.productItems!.map((v) => v.toJson()).toList();
//     }
//     data['isActive'] = this.isActive;
//     if (this.category != null) {
//       data['category'] = this.category!.toJson();
//     }
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     return data;
//   }
// }
//
// class Shop {
//   String? id;
//   String? name;
//   String? slug;
//   String? description;
//   bool? isActive;
//   List<Images>? images;
//   String? createdAt;
//   String? updatedAt;
//
//   Shop(
//       {this.id,
//         this.name,
//         this.slug,
//         this.description,
//         this.isActive,
//         this.images,
//         this.createdAt,
//         this.updatedAt});
//
//   Shop.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     slug = json['slug'];
//     description = json['description'];
//     isActive = json['isActive'];
//     if (json['images'] != null) {
//       images = <Images>[];
//       json['images'].forEach((v) {
//         images!.add(new Images.fromJson(v));
//       });
//     }
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['slug'] = this.slug;
//     data['description'] = this.description;
//     data['isActive'] = this.isActive;
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     return data;
//   }
// }
//
// class Images {
//   String? id;
//   String? url;
//   String? createdAt;
//   String? updatedAt;
//
//   Images({this.id, this.url, this.createdAt, this.updatedAt});
//
//   Images.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     url = json['url'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['url'] = this.url;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     return data;
//   }
// }
//
// class ProductItems {
//   String? id;
//   Product? product;
//   String? sku;
//   String? stock;
//   int? price;
//   List<ProductConfig>? productConfig;
//   bool? isActive;
//   List<Images>? images;
//   String? createdAt;
//   String? updatedAt;
//
//   ProductItems(
//       {this.id,
//         this.product,
//         this.sku,
//         this.stock,
//         this.price,
//         this.productConfig,
//         this.isActive,
//         this.images,
//         this.createdAt,
//         this.updatedAt});
//
//   ProductItems.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     product =
//     json['product'] != null ? new Product.fromJson(json['product']) : null;
//     sku = json['sku'];
//     stock = json['stock'];
//     price = json['price'];
//     if (json['productConfig'] != null) {
//       productConfig = <ProductConfig>[];
//       json['productConfig'].forEach((v) {
//         productConfig!.add(new ProductConfig.fromJson(v));
//       });
//     }
//     isActive = json['isActive'];
//     if (json['images'] != null) {
//       images = <Images>[];
//       json['images'].forEach((v) {
//         images!.add(new Images.fromJson(v));
//       });
//     }
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.product != null) {
//       data['product'] = this.product!.toJson();
//     }
//     data['sku'] = this.sku;
//     data['stock'] = this.stock;
//     data['price'] = this.price;
//     if (this.productConfig != null) {
//       data['productConfig'] =
//           this.productConfig!.map((v) => v.toJson()).toList();
//     }
//     data['isActive'] = this.isActive;
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     return data;
//   }
// }
//
// class Product {
//   String? id;
//   String? name;
//   String? slug;
//   String? status;
//   String? description;
//   int? price;
//   bool? isActive;
//   String? createdAt;
//   String? updatedAt;
//
//   Product(
//       {this.id,
//         this.name,
//         this.slug,
//         this.status,
//         this.description,
//         this.price,
//         this.isActive,
//         this.createdAt,
//         this.updatedAt});
//
//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     slug = json['slug'];
//     status = json['status'];
//     description = json['description'];
//     price = json['price'];
//     isActive = json['isActive'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['slug'] = this.slug;
//     data['status'] = this.status;
//     data['description'] = this.description;
//     data['price'] = this.price;
//     data['isActive'] = this.isActive;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     return data;
//   }
// }
//
// class ProductConfig {
//   String? id;
//
//   ProductConfig({this.id});
//
//   ProductConfig.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     return data;
//   }
// }
//
// class Category {
//   String? id;
//   String? name;
//   String? slug;
//   String? createdAt;
//   String? updatedAt;
//   String? description;
//   Null? image;
//
//   Category(
//       {this.id,
//         this.name,
//         this.slug,
//         this.createdAt,
//         this.updatedAt,
//         this.description,
//         this.image});
//
//   Category.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     slug = json['slug'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     description = json['description'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['slug'] = this.slug;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['description'] = this.description;
//     data['image'] = this.image;
//     return data;
//   }
// }


class SpecificCategoryResponse {
  bool? status;
  List<CategoryDetail>? categoryDetail;
  int? total;
  int? page;
  int? limit;
  int? totalPage;

  SpecificCategoryResponse({
    this.status,
    this.categoryDetail,
    this.total,
    this.page,
    this.limit,
    this.totalPage,
  });

  SpecificCategoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      categoryDetail = <CategoryDetail>[];
      json['data'].forEach((v) {
        categoryDetail!.add(CategoryDetail.fromJson(v));
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
    if (categoryDetail != null) {
      data['data'] = categoryDetail!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['page'] = page;
    data['limit'] = limit;
    data['totalPage'] = totalPage;
    return data;
  }
}

class CategoryDetail {
  String? id;
  String? name;
  String? slug;
  String? status;
  String? description;
  Shop? shop;
  int? price;
  List<ProductTag>? productTag;
  List<ProductItems>? productItems;
  bool? isActive;
  Category? category;
  String? createdAt;
  String? updatedAt;

  CategoryDetail({
    this.id,
    this.name,
    this.slug,
    this.status,
    this.description,
    this.shop,
    this.price,
    this.productTag,
    this.productItems,
    this.isActive,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  CategoryDetail.fromJson(Map<String, dynamic> json) {
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
    if (json['productItems'] != null) {
      productItems = <ProductItems>[];
      json['productItems'].forEach((v) {
        productItems!.add(ProductItems.fromJson(v));
      });
    }
    isActive = json['isActive'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
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
    if (productItems != null) {
      data['productItems'] = productItems!.map((v) => v.toJson()).toList();
    }
    data['isActive'] = isActive;
    if (category != null) {
      data['category'] = category!.toJson();
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
  bool? isActive;
  List<Images>? images;
  String? createdAt;
  String? updatedAt;

  Shop({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.isActive,
    this.images,
    this.createdAt,
    this.updatedAt,
  });

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    isActive = json['isActive'];
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
    data['isActive'] = isActive;
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

  Images({
    this.id,
    this.url,
    this.createdAt,
    this.updatedAt,
  });

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

class ProductItems {
  String? id;
  Product? product;
  String? sku;
  String? stock;
  int? price;
  List<ProductConfig>? productConfig;
  bool? isActive;
  List<Images>? images;
  String? createdAt;
  String? updatedAt;

  ProductItems({
    this.id,
    this.product,
    this.sku,
    this.stock,
    this.price,
    this.productConfig,
    this.isActive,
    this.images,
    this.createdAt,
    this.updatedAt,
  });

  ProductItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    sku = json['sku'];
    stock = json['stock'];
    price = json['price'];
    if (json['productConfig'] != null) {
      productConfig = <ProductConfig>[];
      json['productConfig'].forEach((v) {
        productConfig!.add(ProductConfig.fromJson(v));
      });
    }
    isActive = json['isActive'];
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
    data['isActive'] = isActive;
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
  int? price;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Product({
    this.id,
    this.name,
    this.slug,
    this.status,
    this.description,
    this.price,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    status = json['status'];
    description = json['description'];
    price = json['price'];
    isActive = json['isActive'];
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
    data['price'] = price;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class ProductConfig {
  String? id;
  String? name;
  String? value;
  String? createdAt;
  String? updatedAt;

  ProductConfig({
    this.id,
    this.name,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  ProductConfig.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['value'] = value;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class ProductTag {
  String? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  ProductTag({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  ProductTag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Category {
  String? id;
  String? name;
  String? slug;
  String? description;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Category({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['description'] = description;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
