class GetAddressResponse {
  bool? status;
  List<AddressList>? addressList;

  GetAddressResponse({this.status, this.addressList});

  GetAddressResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      addressList = <AddressList>[];
      json['data'].forEach((v) {
        addressList!.add(AddressList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (addressList != null) {
      data['data'] = addressList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressList {
  String? id;
  bool? isDefault;
  Address? address;
  String? createdAt;
  String? updatedAt;

  AddressList(
      {this.id, this.isDefault, this.address, this.createdAt, this.updatedAt});

  AddressList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDefault = json['isDefault'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isDefault'] = isDefault;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Address {
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

  Address(
      {this.id,
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
      this.updatedAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    alternatePhone = json['alternatePhone'];
    pincode =
        json['pincode'] != null ? Pincode.fromJson(json['pincode']) : null;
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
