import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? email;
  String? password;
  User? user;

  LoginModel({
    this.email,
    this.password,
    this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json["email"],
        password: json["password"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "user": user?.toJson(),
      };
}

class User {
  String? name;
  String? role;

  User({
    this.name,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "role": role,
      };
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });

  Future<Map<String, dynamic>> toJson() async => {
        "email": email,
        "password": password,
      };
}
