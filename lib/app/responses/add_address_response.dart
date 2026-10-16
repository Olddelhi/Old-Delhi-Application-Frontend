// class AddAddressResponse {
//   bool? status;
//   String? message;
//   Address? address;
//
//   AddAddressResponse({this.status, this.message, this.address});
//
//   AddAddressResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     address = json['data'] != null ? new Address.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.address != null) {
//       data['data'] = this.address!.toJson();
//     }
//     return data;
//   }
// }
//
// class Address {
//   String? id;
//   String? name;
//   String? mobile;
//   String? alternatePhone;
//   String? pincode;
//   String? locality;
//   String? address;
//   String? city;
//   String? landmark;
//   String? state;
//   String? createdAt;
//   String? updatedAt;
//
//   Address(
//       {this.id,
//         this.name,
//         this.mobile,
//         this.alternatePhone,
//         this.pincode,
//         this.locality,
//         this.address,
//         this.city,
//         this.landmark,
//         this.state,
//         this.createdAt,
//         this.updatedAt});
//
//   Address.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     mobile = json['mobile'];
//     alternatePhone = json['alternatePhone'];
//     pincode = json['pincode'];
//     locality = json['locality'];
//     address = json['address'];
//     city = json['city'];
//     landmark = json['landmark'];
//     state = json['state'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['mobile'] = this.mobile;
//     data['alternatePhone'] = this.alternatePhone;
//     data['pincode'] = this.pincode;
//     data['locality'] = this.locality;
//     data['address'] = this.address;
//     data['city'] = this.city;
//     data['landmark'] = this.landmark;
//     data['state'] = this.state;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     return data;
//   }
// }


class AddAddressResponse {
  bool? status;
  String? message;
  AddressData? data;

  AddAddressResponse({this.status, this.message, this.data});

  AddAddressResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? AddressData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AddressData {
  String? id;
  String? name;
  String? mobile;
  String? alternatePhone;
  Pincode? pincode;
  String? locality;
  String? address;
  String? city;
  String? landmark;
  String? state;
  String? createdAt;
  String? updatedAt;

  AddressData({
    this.id,
    this.name,
    this.mobile,
    this.alternatePhone,
    this.pincode,
    this.locality,
    this.address,
    this.city,
    this.landmark,
    this.state,
    this.createdAt,
    this.updatedAt,
  });

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    alternatePhone = json['alternatePhone'];
    pincode = json['pincode'] != null ? Pincode.fromJson(json['pincode']) : null;
    locality = json['locality'];
    address = json['address'];
    city = json['city'];
    landmark = json['landmark'];
    state = json['state'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['alternatePhone'] = alternatePhone;
    if (pincode != null) {
      data['pincode'] = pincode!.toJson();
    }
    data['locality'] = locality;
    data['address'] = address;
    data['city'] = city;
    data['landmark'] = landmark;
    data['state'] = state;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Pincode {
  String? id;
  String? pincode;
  String? createdAt;
  String? updatedAt;

  Pincode({this.id, this.pincode, this.createdAt, this.updatedAt});

  Pincode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pincode = json['pincode'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pincode'] = pincode;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
