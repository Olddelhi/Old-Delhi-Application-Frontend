// class SignupResponse {
//   bool? status;
//   String? message;
//   String? token;
//   Data? data;
//
//   SignupResponse({this.status, this.message, this.token, this.data});
//
//   SignupResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     token = json['token'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     data['token'] = this.token;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   User? user;
//
//   Data({this.user});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     user = json['user'] != null ? User.fromJson(json['user']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     return data;
//   }
// }
//
// class User {
//   String? id;
//   String? name;
//   String? phoneNumber;
//   String? email;
//   String? password;
//   bool? isVerified;
//   String? createdAt;
//   String? updatedAt;
//   List<dynamic>? role;
//
//   User(
//       {this.id,
//         this.name,
//         this.phoneNumber,
//         this.email,
//         this.password,
//         this.isVerified,
//         this.createdAt,
//         this.updatedAt,
//         this.role});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     phoneNumber = json['phoneNumber'];
//     if(json['email']==null)
//       {
//         email='';
//       }
//     else{email = json['email'];}
//     password = json['password'];
//     isVerified = json['isVerified'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     // Check if 'role' key exists and is a list
//     if (json.containsKey('role') && json['role'] is List) {
//       role = json['role'] as List<dynamic>; // Assign the role directly
//     } else {
//       role = []; // Assign an empty list if 'role' key is not present or not in the expected format
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['phoneNumber'] = this.phoneNumber;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['isVerified'] = this.isVerified;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     if (this.role != null) {
//       data['role'] = this.role!.map((v) => v?.toJson()).toList();
//     }
//     return data;
//   }
// }

class SignupResponse {
  bool? status;
  String? message;
  String? token;
  Data? data;

  SignupResponse({this.status, this.message, this.token, this.data});

  SignupResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
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
      data['user'] = user?.toJson();
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
  List<Role>? role; // Changed from List<dynamic> to List<Role>

  User(
      {this.id,
      this.name,
      this.phoneNumber,
      this.email,
      this.password,
      this.isVerified,
      this.createdAt,
      this.updatedAt,
      this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'] ?? "";
    password = json['password'];
    isVerified = json['isVerified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['role'] != null) {
      role = List<Role>.from(json['role'].map((x) => Role.fromJson(x)));
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
    if (role != null) {
      data['role'] = role!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Role {
  String? id;
  String? name;
  dynamic
      description; // Assuming description can be of any type, change if it's always string
  bool? isVerified;
  String? createdAt;
  String? updatedAt;

  Role({
    this.id,
    this.name,
    this.description,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
  });

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isVerified = json['isVerified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['isVerified'] = isVerified;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
