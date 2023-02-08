import 'dart:convert';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String password;
  final String imageUrl;
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'imageUrl': imageUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
