class OrderResponse {
  final bool status;
  final List<Order>? data;
  final int totalPage;
  final int page;
  final int limit;

  OrderResponse({
    required this.status,
    this.data,
    required this.totalPage,
    required this.page,
    required this.limit,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      status: json['status'] ?? false,
      data: (json['data'] as List<dynamic>?)?.map((order) => Order.fromJson(order)).toList(),
      totalPage: json['totalPage'] ?? 0,
      page: json['page'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }
}

class Order {
  final String id;
  final dynamic orderNumber;
  final int discount;
  final int grandTotal;
  final List<OrderItem> orderItems;
  final OrderAddress orderAddress;
  final String status;
  final String? paymentId;
  final String? orderId;
  final String paymentGateway;
  final String paymentStatus;
  final String createdAt;
  final String updatedAt;

  Order({
    required this.id,
    this.orderNumber,
    required this.discount,
    required this.grandTotal,
    required this.orderItems,
    required this.orderAddress,
    required this.status,
    this.paymentId,
    this.orderId,
    required this.paymentGateway,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      orderNumber: json['orderNumber'] ?? '',
      discount: json['discount'] ?? 0,
      grandTotal: json['grandTotal'] ?? 0,
      orderItems: (json['orderItems'] as List<dynamic>?)
          ?.map((item) => OrderItem.fromJson(item))
          .toList() ?? [],
      orderAddress: OrderAddress.fromJson(json['orderAddress'] ?? {}),
      status: json['status'] ?? '',
      paymentId: json['paymentId'] ?? '',
      orderId: json['orderId'] ?? '',
      paymentGateway: json['paymentGateway'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class OrderItem {
  final String id;
  final ProductItem productItem;
  final int quantity;
  final int price;
  final String createdAt;
  final String updatedAt;

  OrderItem({
    required this.id,
    required this.productItem,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] ?? '',
      productItem: ProductItem.fromJson(json['productItem'] ?? {}),
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class OrderAddress {
  final String id;
  final String name;
  final String mobile;
  final String? alternatePhone;
  final Pincode pincode; // Update this to use the Pincode class
  final String locality;
  final String address;
  final String city;
  final String landmark;
  final String state;
  final String createdAt;
  final String updatedAt;

  OrderAddress({
    required this.id,
    required this.name,
    required this.mobile,
    this.alternatePhone,
    required this.pincode,
    required this.locality,
    required this.address,
    required this.city,
    required this.landmark,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderAddress.fromJson(Map<String, dynamic> json) {
    return OrderAddress(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      mobile: json['mobile'] ?? '',
      alternatePhone: json['alternatePhone'] ?? '',
      pincode: Pincode.fromJson(json['pincode'] ?? {}), // Use Pincode class
      locality: json['locality'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      landmark: json['landmark'] ?? '',
      state: json['state'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}


class ProductItem {
  final String id;
  final Product product;
  final String sku;
  final String stock;
  final int price;
  final int? weight;
  final List<ProductConfig> productConfig;
  final bool isActive;
  final List<ProductImage> images;
  final String createdAt;
  final String updatedAt;

  ProductItem({
    required this.id,
    required this.product,
    required this.sku,
    required this.stock,
    required this.price,
     this.weight,
    required this.productConfig,
    required this.isActive,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'] ?? '',
      product: Product.fromJson(json['product'] ?? {}),
      sku: json['sku'] ?? '',
      stock: json['stock'] ?? '',
      price: json['price'] ?? 0,
        weight:json['weight']??0,
      productConfig: (json['productConfig'] as List<dynamic>?)
          ?.map((config) => ProductConfig.fromJson(config))
          .toList() ?? [],
      isActive: json['isActive'] ?? false,
      images: (json['images'] as List<dynamic>?)
          ?.map((image) => ProductImage.fromJson(image))
          .toList() ?? [],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class Product {
  final String id;
  final String name;
  final String slug;
  final String status;
  final String description;
  final int? price;
  final bool? isActive;
  final String createdAt;
  final String updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
    required this.description,
    this.price,
    this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      status: json['status'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      isActive: json['isActive'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class ProductConfig {
  final String id;

  ProductConfig({
    required this.id,
  });

  factory ProductConfig.fromJson(Map<String, dynamic> json) {
    return ProductConfig(
      id: json['id'] ?? '',
    );
  }
}

class ProductImage {
  final String id;
  final String url;
  final String createdAt;
  final String updatedAt;

  ProductImage({
    required this.id,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'] ?? '',
      url: json['url'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class Pincode {
  final String id;
  final String pincode;
  final String createdAt;
  final String updatedAt;

  Pincode({
    required this.id,
    required this.pincode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pincode.fromJson(Map<String, dynamic> json) {
    return Pincode(
      id: json['id'] ?? '',
      pincode: json['pincode'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

