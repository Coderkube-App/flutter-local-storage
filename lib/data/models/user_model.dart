import 'package:uuid/uuid.dart';

class UserModel {
  final String id;
  final String email;
  final String password;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
  });

  factory UserModel.create({required String email, required String password}) {
    return UserModel(
      id: const Uuid().v4(),
      email: email,
      password: password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      password: map['password'],
    );
  }
}
