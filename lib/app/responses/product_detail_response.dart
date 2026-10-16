//
// class ProductDetailResponse {
//   bool? status;
//   ProductDetail? productDetail;
//
//   ProductDetailResponse({this.status, this.productDetail});
//
//   ProductDetailResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     productDetail = json['data'] != null ? new ProductDetail.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.productDetail != null) {
//       data['data'] = this.productDetail!.toJson();
//     }
//     return data;
//   }
// }
//
// class ProductDetail {
//   String? id;
//   String? name;
//   String? slug;
//   String? status;
//   String? description;
//   Shop? shop;
//   int? price;
//   List<ProductTag>? productTag;
//   List<ProductItems>? productItems;
//   Category? category;
//   String? createdAt;
//   String? updatedAt;
//
//   ProductDetail(
//       {this.id,
//         this.name,
//         this.slug,
//         this.status,
//         this.description,
//         this.shop,
//         this.price,
//         this.productTag,
//         this.productItems,
//         this.category,
//         this.createdAt,
//         this.updatedAt});
//
//   ProductDetail.fromJson(Map<String, dynamic> json) {
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
//   List<Images>? images;
//   String? createdAt;
//   String? updatedAt;
//
//   Shop(
//       {this.id,
//         this.name,
//         this.slug,
//         this.description,
//         this.images,
//         this.createdAt,
//         this.updatedAt});
//
//   Shop.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     slug = json['slug'];
//     description = json['description'];
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
// class ProductTag {
//   String? id;
//   String? name;
//   String? slug;
//   String? description;
//   String? createdAt;
//   String? updatedAt;
//
//   ProductTag(
//       {this.id,
//         this.name,
//         this.slug,
//         this.description,
//         this.createdAt,
//         this.updatedAt});
//
//   ProductTag.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     slug = json['slug'];
//     description = json['description'];
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
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     return data;
//   }
// }
//
// class ProductConfig {
//   String? id;
//   OptionValue? optionValue;
//   OptionValue? option;
//
//   ProductConfig({this.id, this.optionValue, this.option});
//
//   ProductConfig.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     optionValue = json['optionValue'] != null
//         ? new OptionValue.fromJson(json['optionValue'])
//         : null;
//     option = json['option'] != null
//         ? new OptionValue.fromJson(json['option'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.optionValue != null) {
//       data['optionValue'] = this.optionValue!.toJson();
//     }
//     if (this.option != null) {
//       data['option'] = this.option!.toJson();
//     }
//     return data;
//   }
// }
//
// class OptionValue {
//   String? id;
//   String? value;
//   String? createdAt;
//   String? updatedAt;
//
//   OptionValue({this.id, this.value, this.createdAt, this.updatedAt});
//
//   OptionValue.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     value = json['value'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['value'] = this.value;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
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
//   Images? image;
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
//     image = json['image'] != null ? new Images.fromJson(json['image']) : null;
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
//     if (this.image != null) {
//       data['image'] = this.image!.toJson();
//     }
//     return data;
//   }
// }



class ProductDetailResponse {
  bool? status;
  ProductDetail? productDetail;

  ProductDetailResponse({this.status, this.productDetail});

  ProductDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    productDetail = json['data'] != null ? ProductDetail.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (productDetail != null) {
      data['data'] = productDetail!.toJson();
    }
    return data;
  }
}

class ProductDetail {
  String? id;
  String? name;
  String? slug;
  String? status;
  String? description;
  Shop? shop;
  int? price;
  List<ProductTag>? productTag;
  List<ProductItems>? productItems;
  Category? category;
  String? createdAt;
  String? updatedAt;
  Type? type;
  TimeSlot? timeSlot;
  String? minOrderQuantity;

  ProductDetail({
    this.id,
    this.name,
    this.slug,
    this.status,
    this.description,
    this.shop,
    this.price,
    this.productTag,
    this.productItems,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.timeSlot,
    this.minOrderQuantity,
  });

  ProductDetail.fromJson(Map<String, dynamic> json) {
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
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
    timeSlot = json['timeSlot'] != null ? TimeSlot.fromJson(json['timeSlot']) : null;
    minOrderQuantity = json['minOrderQuantity'];
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
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (type != null) {
      data['type'] = type!.toJson();
    }
    if (timeSlot != null) {
      data['timeSlot'] = timeSlot!.toJson();
    }
    data['minOrderQuantity'] = minOrderQuantity;
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

  Shop({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.images,
    this.createdAt,
    this.updatedAt,
  });

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

class ProductTag {
  String? id;
  String? name;
  String? slug;
  String? description;
  String? createdAt;
  String? updatedAt;

  ProductTag({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

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

class ProductItems {
  String? id;
  Product? product;
  String? sku;
  String? stock;
  int? price;
  List<ProductConfig>? productConfig;
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
  int? price;
  String? createdAt;
  String? updatedAt;

  Product({
    this.id,
    this.name,
    this.slug,
    this.status,
    this.description,
    this.price,
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class ProductConfig {
  String? id;
  OptionValue? optionValue;
  OptionValue? option;

  ProductConfig({
    this.id,
    this.optionValue,
    this.option,
  });

  ProductConfig.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    optionValue = json['optionValue'] != null ? OptionValue.fromJson(json['optionValue']) : null;
    option = json['option'] != null ? OptionValue.fromJson(json['option']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (optionValue != null) {
      data['optionValue'] = optionValue!.toJson();
    }
    if (option != null) {
      data['option'] = option!.toJson();
    }
    return data;
  }
}

class OptionValue {
  String? id;
  String? value;
  String? createdAt;
  String? updatedAt;

  OptionValue({
    this.id,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  OptionValue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Category {
  String? id;
  String? name;
  String? slug;
  String? createdAt;
  String? updatedAt;
  String? description;
  Images? image;

  Category({
    this.id,
    this.name,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.description,
    this.image,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    description = json['description'];
    image = json['image'] != null ? Images.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['description'] = description;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    return data;
  }
}

class Type {
  String? id;
  String? name;
  String? slug;
  String? description;
  Images? image;
  String? createdAt;
  String? updatedAt;

  Type({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    image = json['image'] != null ? Images.fromJson(json['image']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['description'] = description;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class TimeSlot {
  String? id;
  String? slot;
  String? startTime;
  String? endTime;
  String? createdAt;
  String? updatedAt;

  TimeSlot({
    this.id,
    this.slot,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
  });

  TimeSlot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slot = json['slot'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slot'] = slot;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
