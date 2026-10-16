class ProfileResponse {
  bool? status;
  String? message;
  String? token;
  Data? data;

  ProfileResponse({this.status, this.message, this.token, this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool?;
    message = json['message'] as String?;
    token = json['token'] as String?;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['token'] = token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? phoneNumber;
  String? email;
  String? password;
  bool? isVerified;
  String? createdAt;
  String? updatedAt;
  Profile? profile; // Add profile object
  List<dynamic>? role;
  User({
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    this.password,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
    this.profile,
    this.role,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    password = json['password'];
    isVerified = json['isVerified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    profile = json['profile'] != null
        ? Profile.fromJson(json['profile'])
        : null; // Parse profile object
    if (json['role'] != null && json['role'] is List) {
      role = List.from(json['role']);
    } else {
      role = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['password'] = password;
    data['isVerified'] = isVerified;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (profile != null) {
      data['profile'] = profile!.toJson(); // Serialize profile object
    }
    data['role'] = role;
    return data;
  }
}

class Profile {
  String? id;
  String? fullName;
  String? bio;
  Image? image; // Add image object
  String? createdAt;
  String? updatedAt;

  Profile({
    this.id,
    this.fullName,
    this.bio,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['name'];
    bio = json['bio'];
    image = json['image'] != null
        ? Image.fromJson(json['image'])
        : null; // Use Image.fromJson
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['bio'] = bio;
    if (image != null) {
      data['image'] = image!.toJson(); // Use Image.toJson
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Image {
  String? id;
  String? url;
  String? createdAt;
  String? updatedAt;

  Image({
    this.id,
    this.url,
    this.createdAt,
    this.updatedAt,
  });

  Image.fromJson(Map<String, dynamic> json) {
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
