class PincodeResponse {
  dynamic status;
  String? message;
  PincodeData data;

  PincodeResponse({required this.status, this.message, required this.data});

  factory PincodeResponse.fromJson(Map<String, dynamic> json) {
    return PincodeResponse(
      status: json['status'],
      message: json['message'] ?? '',
      data: PincodeData.fromJson(json['data']),
    );
  }
}

class PincodeData {
  String id;
  String pincode;
  List<PostOffice> postOffices;
  String createdAt;
  String updatedAt;

  PincodeData({
    required this.id,
    required this.pincode,
    required this.postOffices,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PincodeData.fromJson(Map<String, dynamic> json) {
    var postOfficesList = json['postOffices'] as List;
    List<PostOffice> postOffices =
    postOfficesList.map((e) => PostOffice.fromJson(e)).toList();

    return PincodeData(
      id: json['id'],
      pincode: json['pincode'],
      postOffices: postOffices,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class PostOffice {
  String id;
  String name;
  String circle;
  String district;
  String division;
  String region;
  String block;
  String state;
  String createdAt;
  String updatedAt;

  PostOffice({
    required this.id,
    required this.name,
    required this.circle,
    required this.district,
    required this.division,
    required this.region,
    required this.block,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostOffice.fromJson(Map<String, dynamic> json) {
    return PostOffice(
      id: json['id'],
      name: json['name'],
      circle: json['circle'],
      district: json['district'],
      division: json['division'],
      region: json['region'],
      block: json['block'],
      state: json['state'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
