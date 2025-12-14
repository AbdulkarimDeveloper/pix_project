import 'dart:convert';

class UserModel {
  String id;
  String username;
  String email;
  int age;
  String password;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.age,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['Id'],
      email: json['Email'],
      age: json['Age'],
      password: json['Password'],
      username: json['UserName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Email': email,
      'Age': age,
      'Password': password,
      'UserName': username,
    };
  }

  static List<UserModel> parseFromString(String data) {
    return List<UserModel>.from(
      json.decode(data).map((e) => UserModel.fromJson(e)),
    );
  }

  static String parseToString(List<UserModel> list) {
    return json.encode(list.map((e) => e.toJson()).toList());
  }
}
